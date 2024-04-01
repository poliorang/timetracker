//
//  CreateGoalViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//


import UIKit

class CreateGoalViewController: UIViewController {

    // MARK: - Private properties
    
    private enum Constants {
        static let timeLabelConst = ["minutes", "hours", "days"]
    }
    
    private let output: CreateGoalViewOutput
    
    private var plusButton: UIButton
    private var descriptionTextField: BasicTextField
    private var projectTextField: BasicTextField
    private var projectsTabControl: TabControl
    private var timeTextField: BasicTextField
    private var timeTabControl: TabControl
    private var startDateTextField: BasicTextField
    private var finishDateTextField: BasicTextField
    private var toolbar: UIToolbar
    
    private var keyboardOffset: CGFloat = 0 {
        didSet {
            print(keyboardOffset)
        }
    }
    private var keyboardShifted: Bool = false
    
    private var contentBottomAnchorConstraint: NSLayoutConstraint?
    
    // MARK: - Init
    
    init(output: CreateGoalViewOutput) {
        self.output = output
        self.plusButton = UIButton().autolayout()
        self.descriptionTextField = BasicTextField().autolayout()
        self.projectTextField = BasicTextField().autolayout()
        self.projectsTabControl = TabControl().autolayout()
        self.timeTextField = BasicTextField().autolayout()
        self.timeTabControl = TabControl().autolayout()
        self.toolbar = UIToolbar().autolayout()
        self.startDateTextField = BasicTextField().autolayout()
        self.finishDateTextField = BasicTextField().autolayout()
        
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
        setupToolbar()
        addKeyboardObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSize(width: 12, height: 12))

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer

        preferredContentSize = CGSize(
            width: 800,
            height: view.systemLayoutSizeFitting(CGSize(
                width: view.bounds.width,
                height: UIView.layoutFittingCompressedSize.height
            )).height
        )
    }
    
    private func setUpUI() {
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(descriptionTextField)
        NSLayoutConstraint.activate([
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextField.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 2),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(projectTextField)
        NSLayoutConstraint.activate([
            projectTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            projectTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            projectTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor),
            projectTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(projectsTabControl)
        NSLayoutConstraint.activate([
            projectsTabControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            projectsTabControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            projectsTabControl.topAnchor.constraint(equalTo: projectTextField.bottomAnchor, constant: 8),
            projectsTabControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(timeTextField)
        NSLayoutConstraint.activate([
            timeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            timeTextField.topAnchor.constraint(equalTo: projectsTabControl.bottomAnchor, constant: 20),
            timeTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(timeTabControl)
        NSLayoutConstraint.activate([
            timeTabControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeTabControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timeTabControl.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 8),
            timeTabControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(startDateTextField)
        NSLayoutConstraint.activate([
            startDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startDateTextField.topAnchor.constraint(equalTo: timeTabControl.bottomAnchor, constant: 20),
            startDateTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(finishDateTextField)
        NSLayoutConstraint.activate([
            finishDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            finishDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            finishDateTextField.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor),
            finishDateTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentBottomAnchorConstraint = finishDateTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        contentBottomAnchorConstraint?.isActive = true
    }
    
    private func setUpAppearance() {
        view.backgroundColor = .white
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .systemGray
        plusButton.addTarget(self, action: #selector(createGoalTap), for: .touchUpInside)
        
        [descriptionTextField, projectTextField, timeTextField, startDateTextField, finishDateTextField].forEach {
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.layer.cornerRadius = 12
            $0.autocorrectionType = .no
        }
        
        descriptionTextField.placeholder = "Description"
        projectTextField.placeholder = "Project"
        projectTextField.autocapitalizationType = .none
        timeTextField.placeholder = "Time"
        timeTextField.keyboardType = .numberPad
        startDateTextField.placeholder = "01.01.01"
        startDateTextField.isDate = true
        finishDateTextField.placeholder = "01.01.01"
        finishDateTextField.isDate = true
        
        projectsTabControl.contentInset.left = 16
        projectsTabControl.onTap = { [weak self] tabText in
            self?.projectTextField.text = tabText
        }
        timeTabControl.contentInset.left = 16
        timeTabControl.labels = Constants.timeLabelConst
    }
    
    private func setupToolbar() {
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, flexSpace, doneBtn]
        toolbar.sizeToFit()
        
        [timeTextField, startDateTextField, finishDateTextField, descriptionTextField, projectTextField].forEach({
            $0.inputAccessoryView = toolbar
        })
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func createGoalTap() {
        output.createGoal(description: descriptionTextField.text,
                          project: projectTextField.text,
                          durationTime: timeTextField.text,
                          durationValue: timeTabControl.selectedLabel?.text,
                          startDate: startDateTextField.text,
                          finishDate: finishDateTextField.text)
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
        if let keyboardHeight = keyboardFrame?.size.height, !keyboardShifted {
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            self.keyboardShifted = true
            
            let contentY = view.frame.height - self.finishDateTextField.frame.origin.y - self.finishDateTextField.frame.height
            
            self.keyboardOffset = keyboardHeight - contentY
            UIView.animate(withDuration: animationDuration, animations: {
                self.contentBottomAnchorConstraint?.constant -= self.keyboardOffset
            })
        }
    }

    @objc private func moveContentWithoutKeyboard(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        
        self.keyboardShifted = false
        
        if keyboardFrame?.size.height != nil {
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            UIView.animate(withDuration: animationDuration, animations: {
                self.contentBottomAnchorConstraint?.constant += self.keyboardOffset
            })
        }
    }
}

extension CreateGoalViewController: CreateGoalViewInput {
    func didGetProjects(projectNames: [Project]) {
        DispatchQueue.main.async { [weak self] in
            self?.projectsTabControl.labels = projectNames
        }
    }
    
    func didErrorData(dataType: CreateGoalDataType) {
        switch dataType {
        case .description:
            descriptionTextField.flashAlert()
        case .project:
            projectTextField.flashAlert()
        case .duration:
            timeTextField.flashAlert()
        case .startDate:
            startDateTextField.flashAlert()
        case .finishDate:
            finishDateTextField.flashAlert()
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
