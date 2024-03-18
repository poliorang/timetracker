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
        static let bgOffsetLeft: CGFloat = 12.0
        static let bgOffsetRight: CGFloat = 30.0
        static let bgOffseTopBottom: CGFloat = 5.0
    }
    
    private weak var delegate: ActionsTableViewDataSourceDelegate?

    private var action: Action?
    private var project: Project?
    private var actionLabel: UILabel
    private var projectLabel: HighlightedLabel

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        actionLabel = UILabel().autolayout()
        projectLabel = HighlightedLabel().autolayout()
        
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
        action: Action,
        project: Project,
        delegate: ActionsTableViewDataSourceDelegate?
    ) {
        self.action = action
        self.project = project
        self.delegate = delegate
    }

    override func prepareForReuse() {
    }
    
    // MARK: - Private functions

    private func setupInitialLayout() {
        contentView.addSubview(projectLabel)
        NSLayoutConstraint.activate([
            projectLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1 * Constants.bgOffsetRight),
            projectLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            projectLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        contentView.addSubview(actionLabel)
        NSLayoutConstraint.activate([
            actionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.bgOffsetLeft),
            actionLabel.rightAnchor.constraint(lessThanOrEqualTo: projectLabel.leftAnchor, constant: -1 * Constants.bgOffsetLeft),
            actionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func configureView() {
        actionLabel.text = action
        actionLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        
        projectLabel.text = project
        projectLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        projectLabel.sizeToFit()
    }
}



