//
//  ViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

protocol TimerViewControllerDelegate: AnyObject {
    func update(action: ActionProject?)
}

class TimerViewController: UIViewController {

    // MARK: - Private properties

    private enum ScreenState {
        case empty
        case info
        case time
    }
    
    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let startImage = UIImage(systemName: "play.fill")
        static let stopImage = UIImage(systemName: "stop.fill")
        static let textFieldButtonImageSystemName: String = "control"
        static let actionTextFieldPlaceholder: String = "Action"
        static let projectTextFieldPlaceholder: String = "Project"
    }

    private let output: TimerViewOutput

    private var playButton: UIButton
    private var actionTextField: BasicTextField
    private var actionsButton: UIButton
    private var projectTextField: BasicTextField
    private var projectsTabControl: TabControl
    
    private var selectedProjectLabel: UILabel
    private var selectedActionLabel: UILabel
    private var timerLabel: UILabel

    private var screenState: ScreenState = .empty
    private var keyboardShifted = false
    private var centerYAnchorConstraint: NSLayoutConstraint?
    
    // MARK: - Init

    init(output: TimerViewOutput) {
        self.output = output
        self.playButton = UIButton().autolayout()
        self.actionTextField = BasicTextField().autolayout()
        self.actionsButton = UIButton().autolayout()
        self.projectTextField = BasicTextField().autolayout()
        self.projectsTabControl = TabControl().autolayout()
        self.selectedProjectLabel = UILabel().autolayout()
        self.selectedActionLabel = UILabel().autolayout()
        self.timerLabel = UILabel().autolayout()

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
        addKeyboardObservers()
        output.setProjects()
    }

    // MARK: - Private functions

    private func setUpUI() {
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        centerYAnchorConstraint = playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYAnchorConstraint?.isActive = true
        view.addSubview(actionTextField)
        NSLayoutConstraint.activate([
            actionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionTextField.topAnchor.constraint(equalTo: playButton.bottomAnchor),
            actionTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(actionsButton)
        NSLayoutConstraint.activate([
            actionsButton.centerYAnchor.constraint(equalTo: actionTextField.centerYAnchor),
            actionsButton.trailingAnchor.constraint(equalTo: actionTextField.trailingAnchor),
            actionsButton.widthAnchor.constraint(equalToConstant: 50),
            actionsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(projectTextField)
        NSLayoutConstraint.activate([
            projectTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            projectTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            projectTextField.topAnchor.constraint(equalTo: actionTextField.bottomAnchor),
            projectTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(projectsTabControl)
        NSLayoutConstraint.activate([
            projectsTabControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            projectsTabControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            projectsTabControl.topAnchor.constraint(equalTo: projectTextField.bottomAnchor, constant: 8),
            projectsTabControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(selectedProjectLabel)
        NSLayoutConstraint.activate([
            selectedProjectLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedProjectLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 12),
            selectedProjectLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        selectedProjectLabel.isHidden = true
        view.addSubview(selectedActionLabel)
        NSLayoutConstraint.activate([
            selectedActionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedActionLabel.topAnchor.constraint(equalTo: selectedProjectLabel.bottomAnchor, constant: 8),
            selectedActionLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        selectedActionLabel.isHidden = true
        
        view.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: selectedActionLabel.bottomAnchor, constant: 8),
            timerLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        timerLabel.isHidden = true
    }

    private func setUpAppearance() {
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onScreenTap(_:)))
        view.addGestureRecognizer(tap)
        
        playButton.setBackgroundImage(Constants.startImage, for: .normal)
        playButton.tintColor = .black
        playButton.contentMode = .scaleAspectFit
        playButton.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
        
        actionTextField.placeholder = Constants.actionTextFieldPlaceholder
        actionTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        actionTextField.delegate = self
        actionTextField.alpha = 0
        actionTextField.layer.cornerRadius = 12
        actionTextField.autocorrectionType = .no

        actionsButton.tintColor = .gray
        let imageActionButton = UIImage(systemName: Constants.textFieldButtonImageSystemName)!
        let flippedImage = UIImage(
            cgImage: imageActionButton.cgImage!,
            scale: imageActionButton.scale,
            orientation: .downMirrored
        )
        actionsButton.setImage(flippedImage, for: .normal)
        actionsButton.alpha = 0
        actionsButton.addTarget(self, action: #selector(openActions), for: .touchUpInside)
        
        projectTextField.placeholder = Constants.projectTextFieldPlaceholder
        projectTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        projectTextField.delegate = self
        projectTextField.alpha = 0
        projectTextField.layer.cornerRadius = 12
        projectTextField.autocapitalizationType = .none
        projectTextField.autocorrectionType = .no

        projectsTabControl.alpha = 0
        projectsTabControl.contentInset.left = 16
        projectsTabControl.onTap = { [weak self] tabText in
            self?.projectTextField.text = tabText
        }
        
        selectedActionLabel.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        timerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        timerLabel.textColor = .systemGray2
        timerLabel.text = ""
    }
    
    @objc private func playButtonTap() {
        switch screenState {
        case .empty:
            onScreenTap()
        case .info:
            startTimer()
        case .time:
            stopTimer()
        }
    }

    private func startTimer() {
        guard let actionName = actionTextField.text?.trimmedAndNormalized,
              let projectName = projectTextField.text?.trimmedAndNormalized,
              !actionName.isEmpty, !projectName.isEmpty else {
                  actionTextField.flashAlert()
                  projectTextField.flashAlert()
                  return
        }
        screenState = .time
        playButton.setBackgroundImage(Constants.stopImage, for: .normal)
        
        selectedProjectLabel.text = projectName
        selectedActionLabel.text = actionName
        selectedProjectLabel.isHidden = false
        selectedActionLabel.isHidden = false
        timerLabel.isHidden = false
        actionTextField.isHidden = true
        projectTextField.isHidden = true
        projectsTabControl.isHidden = true
        actionsButton.isHidden = true
        
        output.startTime()
        
    }
    
    private func stopTimer() {
        guard let actionName = actionTextField.text?.trimmedAndNormalized,
              let projectName = projectTextField.text?.trimmedAndNormalized else {
            return
        }
        screenState = .empty
        playButton.setBackgroundImage(Constants.startImage, for: .normal)
        
        projectTextField.text = ""
        actionTextField.text = ""
        selectedProjectLabel.text = ""
        selectedActionLabel.text = ""
        
        selectedProjectLabel.isHidden = true
        selectedActionLabel.isHidden = true
        timerLabel.isHidden = true
        actionTextField.isHidden = false
        projectTextField.isHidden = false
        projectsTabControl.isHidden = false
        actionsButton.isHidden = false
        
        actionTextField.alpha = 0
        projectTextField.alpha = 0
        projectsTabControl.alpha = 0
        actionsButton.alpha = 0
        
        timerLabel.text = ""
        output.stopTime()
        output.сreateActionWithProject(action: actionName, project: projectName)
    }

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveContentWithKeyboard),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveContentWithoutKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc private func moveContentWithKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        if keyboardFrame?.size.height != nil {
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            UIView.animate(withDuration: animationDuration, animations: {
                if !self.keyboardShifted {
                    self.centerYAnchorConstraint?.constant -= 70
                    self.keyboardShifted = true
                }
            })
        }
    }

    @objc private func moveContentWithoutKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        if keyboardFrame?.size.height != nil {
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            UIView.animate(withDuration: animationDuration, animations: {
                if self.keyboardShifted {
                    self.centerYAnchorConstraint?.constant += 70
                    self.keyboardShifted = false
                }
            })
        }
    }
    
    @objc private func openActions() {
        output.openActions()
    }

    @objc private func onScreenTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.actionTextField.alpha = 1
            self.actionsButton.alpha = 1
            self.projectTextField.alpha = 1
            self.projectsTabControl.alpha = 1
        })
        screenState = .info
    }
}

extension TimerViewController: TimerViewInput {
    
    func didUpdateTime(time: String) {
        timerLabel.text = time
    }
    
    func present(module: UIViewController) {
        guard let childViewController = module as? ActionViewController else { return }
        childViewController.delegate = self
        present(childViewController, animated: true)
    }
    
    func didGetProjects(projectNames: [Project]) {
        DispatchQueue.main.async { [weak self] in
            self?.projectsTabControl.labels = projectNames
        }
    }
}

extension TimerViewController: TimerViewControllerDelegate {
    func update(action: ActionProject?) {
        guard let action = action else { return }
        actionTextField.text = action.0
        projectTextField.text = action.1
        projectsTabControl.setSelectedLabel(text: action.1)
    }
}

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
