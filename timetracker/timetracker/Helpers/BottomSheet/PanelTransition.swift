//
//  PanelTransition.swift
//  timetracker
//
//  Created by Поли Оранж on 01.04.2024.
//

import Foundation
import UIKit

public class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {

    private let driver = TransitionDriver()
    private let shadowColor: () -> UIColor

    public init(shadowColor: @escaping () -> UIColor = { UIColor(white: 0, alpha: 0.3) }) {
        self.shadowColor = shadowColor
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)
        let presentationController = ShadowPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source,
            driver: driver,
            shadowColor: shadowColor
        )
        presentationController.driver = driver
        return presentationController
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}


final class TransitionDriver: UIPercentDrivenInteractiveTransition {

    enum TransitionDirection {
        case present, dismiss
    }

    var direction: TransitionDirection = .present
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?

    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }

        set { }
    }

    func link(to controller: UIViewController) {
        presentedController = controller

        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }

    @objc private func handle(recognizer r: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: r)
        case .dismiss:
            handleDismiss(recognizer: r)
        }
    }
}

extension TransitionDriver {

    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }

    private var isRunning: Bool {
        return percentComplete != 0
    }

    private func handlePresentation(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
        case .changed:
            let increment = -r.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
        case .failed:
            cancel()
        default:
            break
        }
    }

    private func handleDismiss(recognizer r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            pause()
            if !isRunning {
                presentedController?.dismiss(animated: true)
            }
        case .changed:
            update(percentComplete + r.incrementToBottom(maxTranslation: maxTranslation))
        case .ended, .cancelled:
            if r.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }

        case .failed:
            cancel()
        default:
            break
        }
    }
}

private extension UIPanGestureRecognizer {
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2

        return isPresentationCompleted
    }

    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
}

private extension UIPanGestureRecognizer {
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
}

private extension CGPoint {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(
            x: x.projectedOffset(decelerationRate: decelerationRate),
            y: y.projectedOffset(decelerationRate: decelerationRate)
        )
    }
}

private extension CGFloat {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}

private extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(
            x: left.x + right.x,
            y: left.y + right.y
        )
    }
}

