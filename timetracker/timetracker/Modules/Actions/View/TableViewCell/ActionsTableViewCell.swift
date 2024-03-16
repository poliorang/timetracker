//
//  ActionsTableViewCell.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

import UIKit

final class ActionsTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let bgOffsetLeftRight: CGFloat = 12.0
        static let bgOffseTopBottom: CGFloat = 5.0
    }
    
    private weak var delegate: ActionsTableViewDataSourceDelegate?

    private var actionName: String?
    private var label: UILabel

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        label = UILabel().autolayout()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpUI() {
        setupInitialLayout()
        configureView()
    }
    
    public func configure(
        actionName: String,
        delegate: ActionsTableViewDataSourceDelegate?
    ) {
        self.delegate = delegate
        self.actionName = actionName
    }

    override func prepareForReuse() {
    }
    
    // MARK: - Private functions

    private func setupInitialLayout() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.bgOffsetLeftRight),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * Constants.bgOffsetLeftRight),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func configureView() {
        label.text = actionName
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
    }
}



