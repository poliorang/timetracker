//
//  BasicTextField.swift
//  timetracker
//
//  Created by Polina Egorova on 13.03.2024.
//

import UIKit

final class BasicTextField: UITextField {

    // MARK: Private Properties

    private let bottomLine = CALayer()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
    }

    // MARK: - Private functions

    private func updateAppearance() {
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
