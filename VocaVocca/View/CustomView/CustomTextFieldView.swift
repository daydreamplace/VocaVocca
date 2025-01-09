//
//  CustomTextFieldView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class CustomTextFieldView: UIView, UITextFieldDelegate {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let borderView = UIView()
    
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
     
        }
}
