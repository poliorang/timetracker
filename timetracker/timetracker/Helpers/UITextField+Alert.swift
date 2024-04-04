//
//  UITextField+Alert.swift
//  timetracker
//
//  Created by Polina Egorova on 20.03.2024.
//

import UIKit

extension UITextField {
    func flashAlert() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.center.x += 10
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.center.x -= 20
            }) { _ in
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                UIView.animate(withDuration: 0.1, animations: { [weak self] in
                    self?.center.x += 20
                }) { _ in
                    UIView.animate(withDuration: 0.1, animations: { [weak self] in
                        self?.center.x -= 10
                    }) { _ in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }
            }
        }
    }
}
