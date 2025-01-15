//
//  CustomTextFieldView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class CustomTextFieldView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .customDarkBrown
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.font = UIFont.systemFont(ofSize: 14)
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isUserInteractionEnabled = true
        return field
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .customDarkBrown
        return button
    }()
    
    //var didTapSearchButton: (() -> Void)?
    var didEndEditing: ((String) -> Void)?
    
    // MARK: - Initialization
    
    init(title: String, placeholder: String, showSearchButton: Bool = false) {
        super.init(frame: .zero)
        setupUI(title: title, placeholder: placeholder)
        if showSearchButton {
            textField.rightView = searchButton
            textField.rightViewMode = .always
        } else {
            textField.rightView = nil
        }
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI(title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
        
        addSubviews(titleLabel, textField)
        
        textField.rightView = searchButton
        textField.rightViewMode = .always
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
        
//        textField.rightView?.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//        }
    }
    
    // MARK: - Update Method
    
    func update(title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }
    
    func updatePlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
}

// MARK: - UITextFieldDelegate

extension CustomTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.customDarkerBrown.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        if let text = textField.text, !text.isEmpty {
            didEndEditing?(text)
        }
    }
}
