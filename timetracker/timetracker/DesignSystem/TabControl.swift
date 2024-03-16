//
//  TabControl.swift
//  timetracker
//
//  Created by Polina Egorova on 13.03.2024.
//

import UIKit

final class TabControl: UIScrollView {

    public var onTap: ((String) -> Void)?
    
    public var labels: [String] = [] {
        didSet {
            setupLabels()
        }
    }
    // MARK: - Private properties
    
    private enum Constants {
        static let fontSize: CGFloat = 14.0
        static let labelBackgroundColor: UIColor = .clear
        static let labelTextColor: UIColor = .systemGray2
        static let labelSelectedBackgroundColor: UIColor = .systemGray6
        static let labelSelectedTextColor: UIColor = .black
    }
    
    private var selectedLabel: UILabel?
    
    // MARK: - Private functions
    
    private func setupLabels() {
        subviews.forEach { $0.removeFromSuperview() }
        showsHorizontalScrollIndicator = false

        var xOffset: CGFloat = 0

        for (index, labelText) in labels.enumerated() {
            let label = UILabel()
            label.backgroundColor = Constants.labelBackgroundColor
            label.text = labelText
            label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
            label.textAlignment = .center
            label.textColor = Constants.labelTextColor
            label.sizeToFit()

            label.layer.cornerRadius = min(label.frame.height, label.frame.width)
            label.clipsToBounds = true

            label.frame = CGRect(x: xOffset, y: 0, width: label.frame.size.width + 32, height: 32)
            self.addSubview(label)

            xOffset += label.frame.size.width + 10

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
            if index == 0 {
                label.backgroundColor = Constants.labelSelectedBackgroundColor
                label.textColor = Constants.labelSelectedTextColor
                selectedLabel = label
            }
        }
    
        contentSize = CGSize(width: xOffset, height: 32)
    }

    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedLabel = sender.view as? UILabel else { return }
        
        if let prevSelectedLabel = selectedLabel {
            prevSelectedLabel.backgroundColor = Constants.labelBackgroundColor
            prevSelectedLabel.textColor = Constants.labelTextColor
        }
        
        tappedLabel.backgroundColor = Constants.labelSelectedBackgroundColor
        tappedLabel.textColor = Constants.labelSelectedTextColor
        selectedLabel = tappedLabel
        
        if let labelText = tappedLabel.text {
            onTap?(labelText)
        }
    }
}
