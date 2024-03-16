//
//  ViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

protocol TimerViewControllerDelegate: AnyObject {
    func update(action: String?)
}

class TimerViewController: UIViewController {

    // MARK: - Private properties

    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let mainImageSystemName: String = "play.fill"
        static let textFieldButtonImageSystemName: String = "control"
        static let actionTextFieldPlaceholder: String = "Action"
        static let projectTextFieldPlaceholder: String = "Project"
    }
    
    private let output: TimerViewOutput
    
    private var playImage: UIImageView
    private var actionTextField: BasicTextField
    private var actionsButton: UIButton
    private var projectTextField: BasicTextField
    private var projectsTabControl: TabControl
    
    private var keyboardShifted = false
    private var centerYAnchorConstraint: NSLayoutConstraint?

    // MARK: - Init

    init(output: TimerViewOutput) {
        self.output = output
        self.playImage = UIImageView().autolayout()
        self.actionTextField = BasicTextField().autolayout()
        self.actionsButton = UIButton().autolayout()
        self.projectTextField = BasicTextField().autolayout()
        self.projectsTabControl = TabControl().autolayout()

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
    }

    // MARK: - Private functions

    private func setUpUI() {
        view.addSubview(playImage)
        NSLayoutConstraint.activate([
            playImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playImage.heightAnchor.constraint(equalToConstant: 40),
            playImage.widthAnchor.constraint(equalToConstant: 40)
        ])
        centerYAnchorConstraint = playImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYAnchorConstraint?.isActive = true
        view.addSubview(actionTextField)
        NSLayoutConstraint.activate([
            actionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionTextField.topAnchor.constraint(equalTo: playImage.bottomAnchor),
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }

    private func setUpAppearance() {
        view.backgroundColor = .white
        playImage.image = UIImage(systemName: Constants.mainImageSystemName)!
        playImage.contentMode = .scaleAspectFit
        playImage.tintColor = .black
        
        actionTextField.placeholder = Constants.actionTextFieldPlaceholder
        actionTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        actionTextField.delegate = self
        actionTextField.alpha = 0
        
        actionsButton.tintColor = .gray
        let image = UIImage(systemName: Constants.textFieldButtonImageSystemName)!
        let flippedImage = UIImage(
            cgImage: image.cgImage!,
            scale: image.scale,
            orientation: .downMirrored
        )
        actionsButton.setImage(flippedImage, for: .normal)
        actionsButton.alpha = 0
        actionsButton.addTarget(self, action: #selector(openActions), for: .touchUpInside)
        projectTextField.placeholder = Constants.projectTextFieldPlaceholder
        projectTextField.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        projectTextField.delegate = self
        projectTextField.alpha = 0
        
        projectsTabControl.alpha = 0
        projectsTabControl.contentInset.left = 16
        projectsTabControl.labels = output.projects()
        projectsTabControl.onTap = { [weak self] tabText in
            self?.projectTextField.text = tabText
        }

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.actionTextField.alpha = 1
            self.actionsButton.alpha = 1
            self.projectTextField.alpha = 1
            self.projectsTabControl.alpha = 1
        })
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
        if keyboardFrame?.size.height != nil{
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
        output.didTapOpenActions()
    }
}

extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TimerViewController: TimerViewInput {
    func present(module: UIViewController) {
        guard let childViewController = module as? ActionViewController else { return }
        childViewController.delegate = self
        present(childViewController, animated: true)
    }
}

extension TimerViewController: TimerViewControllerDelegate {
    func update(action: String?) {
        self.actionTextField.text = action
    }
}
