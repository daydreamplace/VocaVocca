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
    
    private let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.font = UIFont.systemFont(ofSize: 14)
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isUserInteractionEnabled = true
        return field
    }()
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    // MARK: - Initialization
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        setupUI(title: title, placeholder: placeholder)
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
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(60)
        }
    }
    
    // MARK: - Update Method
    
    /// 텍스트 필드의 제목 및 플레이스홀더를 동적으로 업데이트
    func update(title: String, placeholder: String) {
        titleLabel.text = title
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
    }
}
