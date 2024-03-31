//
//  GoalsTableViewCell.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

final class GoalsTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private enum Constants {
        static let normalFontSize: CGFloat = 16.0
        static let smallFontSize: CGFloat = 12.0
        static let secondatyFontColor: UIColor = .systemGray
    }
    
    private weak var delegate: GoalsTableViewDataSourceDelegate?

    private var goal: GoalModel?
    
    private var descriptionLabel: UILabel
    private var totalTimeLabel: UILabel
    private var timeDurationLabel: UILabel
    private var startTimeLabel: UILabel
    private var finishTimeLabel: UILabel
    private var progressView: UIProgressView

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        descriptionLabel = UILabel().autolayout()
        totalTimeLabel = UILabel().autolayout()
        timeDurationLabel = UILabel().autolayout()
        startTimeLabel = UILabel().autolayout()
        finishTimeLabel = UILabel().autolayout()
        progressView = UIProgressView().autolayout()
        
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
        goal: GoalModel,
        delegate: GoalsTableViewDataSourceDelegate?
    ) {
        self.goal = goal
        self.delegate = delegate
    }

    override func prepareForReuse() {
        descriptionLabel.text = nil
        totalTimeLabel.text = nil
    }
    
    // MARK: - Private functions

    private func setupInitialLayout() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        contentView.addSubview(startTimeLabel)
        NSLayoutConstraint.activate([
            startTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            startTimeLabel.widthAnchor.constraint(equalToConstant: 100),
            startTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8)
        ])
        
        contentView.addSubview(finishTimeLabel)
        NSLayoutConstraint.activate([
            finishTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            finishTimeLabel.widthAnchor.constraint(equalToConstant: 100),
            finishTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 2)
        ])

        contentView.addSubview(totalTimeLabel)
        NSLayoutConstraint.activate([
            totalTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            totalTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            totalTimeLabel.trailingAnchor.constraint(lessThanOrEqualTo: startTimeLabel.leadingAnchor, constant: -8)
        ])
        
        contentView.addSubview(timeDurationLabel)
        NSLayoutConstraint.activate([
            timeDurationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeDurationLabel.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: 2),
            timeDurationLabel.trailingAnchor.constraint(equalTo: finishTimeLabel.leadingAnchor, constant: -8)
        ])
        
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressView.topAnchor.constraint(equalTo: timeDurationLabel.bottomAnchor, constant: 12),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func configureView() {
        descriptionLabel.text = goal?.name
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: Constants.normalFontSize)
        descriptionLabel.sizeToFit()

        totalTimeLabel.text = goal?.timeSeconds.wordsStringFromSeconds()
        totalTimeLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        totalTimeLabel.textColor = Constants.secondatyFontColor
        
        timeDurationLabel.text = goal?.durationInSeconds.clockFaceStringFromSeconds()
        timeDurationLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        timeDurationLabel.textColor = Constants.secondatyFontColor
        
        startTimeLabel.text = goal?.dateStart.toStringDate()
        startTimeLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        startTimeLabel.textColor = Constants.secondatyFontColor
        startTimeLabel.textAlignment = .right
        
        finishTimeLabel.text = goal?.dateEnd.toStringDate()
        finishTimeLabel.font = UIFont.boldSystemFont(ofSize: Constants.smallFontSize)
        finishTimeLabel.textColor = Constants.secondatyFontColor
        finishTimeLabel.textAlignment = .right
        
        if let percent = goal?.percent, percent > 0 {
            progressView.setProgress(Float(percent / 100), animated: false)
        }
        progressView.progressTintColor = .gray
        progressView.layer.borderColor = UIColor.gray.cgColor
        progressView.layer.borderWidth = 0.1
    }
}
