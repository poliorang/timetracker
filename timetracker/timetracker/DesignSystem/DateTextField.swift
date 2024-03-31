//
//  DateTextField.swift
//  timetracker
//
//  Created by Polina Egorova on 30.03.2024.
//

import UIKit

class DateTextField: UITextField {
    
    public var isCorrect: Bool = true
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    
    // MARK: - Private functions
    
    private func setupTextField() {
        self.backgroundColor = .clear
        textColor = .systemGray2
        autocorrectionType = .no
        keyboardType = .numberPad
        font = UIFont.boldSystemFont(ofSize: 12)
        
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        
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
    
    @objc private func textFieldDidBeginEditing() {
        self.text = ""
    }
}

extension DateTextField: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
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
