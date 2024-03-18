//
//  HighlightedLabel.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

import UIKit

class HighlightedLabel: UILabel {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let fontSize: CGFloat = 14.0
        static let backgroundColor: UIColor = .systemGray6
        static let textColor: UIColor = .black
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let newSize = intrinsicContentSize
        frame.size = CGSize(width: newSize.width + 25, height: 32)
        layer.cornerRadius = frame.height / 2
        font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        backgroundColor =  Constants.backgroundColor
        textColor = Constants.textColor
        clipsToBounds = true
        textAlignment = .center
    }
}

