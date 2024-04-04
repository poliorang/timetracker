//
//  AnalyticsTableViewCell.swift
//  timetracker
//
//  Created by Polina Egorova on 30.03.2024.
//

import UIKit

final class AnalyticsTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let smallFontSize: CGFloat = 14.0
    }
    
    private weak var delegate: AnalyticsTableViewDataSourceDelegate?

    private var analytic: AnalyticModel?
    
    private var colorImageView: UIImageView
    private var projectLabel: UILabel
    private var percentDurationLabel: UILabel
    private var timeDurationLabel: UILabel

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        colorImageView = UIImageView().autolayout()
        projectLabel = UILabel().autolayout()
        percentDurationLabel = UILabel().autolayout()
        timeDurationLabel = UILabel().autolayout()
        
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
        analytic: AnalyticModel,
        delegate: AnalyticsTableViewDataSourceDelegate?
    ) {
        self.analytic = analytic
        self.delegate = delegate
    }

    override func prepareForReuse() {
        colorImageView.image = nil
        projectLabel.text = nil
        percentDurationLabel.text = nil
        timeDurationLabel.text = nil
    }
    
    // MARK: - Private functions

    private func setupInitialLayout() {
        contentView.addSubview(colorImageView)
        NSLayoutConstraint.activate([
            colorImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            colorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorImageView.heightAnchor.constraint(equalToConstant: 12),
            colorImageView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        contentView.addSubview(timeDurationLabel)
        NSLayoutConstraint.activate([
            timeDurationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            timeDurationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.addSubview(percentDurationLabel)
        NSLayoutConstraint.activate([
            percentDurationLabel.rightAnchor.constraint(equalTo: timeDurationLabel.leftAnchor, constant: -12),
            percentDurationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.addSubview(projectLabel)
        NSLayoutConstraint.activate([
            projectLabel.leftAnchor.constraint(equalTo: colorImageView.rightAnchor, constant: 8),
            projectLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            projectLabel.rightAnchor.constraint(lessThanOrEqualTo: percentDurationLabel.leftAnchor, constant: -8),
        ])
    }

    private func configureView() {
        colorImageView.image = UIImage(systemName: "circle.fill")
        colorImageView.tintColor = analytic?.color
        colorImageView.contentMode = .scaleAspectFit
        colorImageView.sizeToFit()

        projectLabel.text = analytic?.name
        projectLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        projectLabel.sizeToFit()
        
        percentDurationLabel.text = "\(Double(round(100 * (analytic?.percentDuration ?? 0)) / 100))%"
        percentDurationLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        percentDurationLabel.textColor = .systemGray2
        
        timeDurationLabel.text = analytic?.durationInSeconds?.clockFaceStringFromSeconds()
        timeDurationLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        timeDurationLabel.textColor = .systemGray2
    }
}
