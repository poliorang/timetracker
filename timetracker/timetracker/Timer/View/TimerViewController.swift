//
//  ViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

class TimerViewController: UIViewController {

    // MARK: - Private properties

    private enum Constants {
        static let imageSystemName: String = "play.fill"
    }
    private var playImage: UIImageView

    // MARK: - Init

    init() {
        self.playImage = UIImageView().autolayout()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpAppearance()
    }

    // MARK: - Private functions

    private func setUpUI() {
        view.addSubview(playImage)
        NSLayoutConstraint.activate([
            playImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playImage.heightAnchor.constraint(equalToConstant: 40),
            playImage.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }

    private func setUpAppearance() {
        view.backgroundColor = .white
        playImage.image = UIImage(systemName: Constants.imageSystemName)!
        playImage.contentMode = .scaleAspectFit
        playImage.tintColor = .black
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        view.backgroundColor = view.backgroundColor == .red ? .blue: .red
    }
}
