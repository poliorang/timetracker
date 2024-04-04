//
//  ShadowPresentationController.swift
//  timetracker
//
//  Created by Поли Оранж on 01.04.2024.
//

import Foundation
import UIKit

final class ShadowPresentationController: UIPresentationController {

    var driver: TransitionDriver
    private let shadowColor: () -> UIColor

    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = shadowColor()
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(processTap)))
        return view
    }()

    private var topInset: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    }

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return CGRect(origin: .zero, size: .zero) }
        let controllerHeight = min(presentedViewController.preferredContentSize.height, bounds.height - topInset)
        let controllerWidth = min(presentedViewController.preferredContentSize.width, UIScreen.main.bounds.width)
        return CGRect(
            x: (UIScreen.main.bounds.width - controllerWidth) / 2,
            y: bounds.height - controllerHeight,
            width: controllerWidth,
            height: controllerHeight
        )
    }

    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         driver: TransitionDriver,
         shadowColor: @escaping () -> UIColor
    ) {
        self.driver = driver
        self.shadowColor = shadowColor
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
    }

    @objc private func paintThemeColor() {
        shadowView.backgroundColor = shadowColor()
    }

    @objc private func processTap() {
        presentedViewController.dismiss(animated: true)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
        containerView?.insertSubview(shadowView, at: 0)
        performAlongsideTransitionIfPossible { [unowned self] in
            self.shadowView.alpha = 1
        }
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        shadowView.frame = containerView!.frame
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            driver.direction = .dismiss
        }
        if !completed {
            self.shadowView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible { [unowned self] in
            self.shadowView.alpha = 0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            self.shadowView.removeFromSuperview()
        }
    }

    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            block()
        }, completion: nil)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)

        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        self.presentedView?.layoutIfNeeded()
    }
}

