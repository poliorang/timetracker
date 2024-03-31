//
//  BasicTextField.swift
//  timetracker
//
//  Created by Polina Egorova on 13.03.2024.
//

import UIKit

final class BasicTextField: UITextField {

    public var isCorrect: Bool = true
    
    public var isDate: Bool = false {
        didSet {
            setUpDateMode()
        }
    }
    
    // MARK: Private Properties

    private let bottomLine = CALayer()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
    }

    // MARK: - Private functions

    private func updateAppearance() {
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    private func setUpDateMode() {
        keyboardType = .numberPad
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        delegate = self
    }
    
    @objc private func textFieldDidChange() {
        guard let text = self.text else { return }
        
        // Удаляем все символы, кроме цифр
        let cleanText = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        
        // Добавляем точку после каждых двух символов
        var formattedText = ""
        var index = cleanText.startIndex
        while index < cleanText.endIndex {
            let nextIndex = cleanText.index(index, offsetBy: 2, limitedBy: cleanText.endIndex) ?? cleanText.endIndex
            formattedText += cleanText[index..<nextIndex]
            if nextIndex != cleanText.endIndex {
                formattedText += "."
            }
            index = nextIndex
        }
        
        self.text = formattedText.prefix(8).description
    }
}

extension BasicTextField: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if !isDate {
            return true
        }
        
        if let text = textField.text, !text.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            if dateFormatter.date(from: text) != nil {
                isCorrect = true
                return true
            }
            
            isCorrect = false
            UIView.animate(withDuration: 0.1, animations: { [weak self] in
                self?.center.x += 10
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: { [weak self] in
                    self?.center.x -= 20
                }) { _ in
                    UIView.animate(withDuration: 0.1, animations: { [weak self] in
                        self?.center.x += 20
                    }) { _ in
                        UIView.animate(withDuration: 0.1, animations: { [weak self] in
                            self?.center.x -= 10
                        }) { _ in
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    }
                }
            }
        }
        
        return false
    }
}
