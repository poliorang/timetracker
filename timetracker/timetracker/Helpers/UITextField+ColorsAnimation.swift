//
//  UITextField+ColorsAnimation.swift
//  timetracker
//
//  Created by Polina Egorova on 20.03.2024.
//

import UIKit

extension UITextField {
    func flashAlert() {
        let originalColor = self.backgroundColor
        self.backgroundColor = #colorLiteral(red: 0.9446148276, green: 0.4598113894, blue: 0.4505882859, alpha: 1)

        UIView.animate(withDuration: 1, animations: {
            self.backgroundColor = originalColor
        })
    }
}
