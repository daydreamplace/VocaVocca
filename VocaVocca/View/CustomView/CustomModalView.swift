//
//  CustomModalView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class CustomModalView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let confirmButton: CustomButton
    
    // MARK: - Action
    
    var onCloseButtonTapped: (() -> Void)?
    var onConfirmButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    
    init(title: String, buttonTitle: String, action: (() -> Void)? = nil) {
        self.confirmButton = CustomButton(title: buttonTitle, action: action)
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        addSubviews(titleLabel, closeButton, contentStackView, confirmButton)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(closeButton.snp.leading).offset(-8)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(30)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Button Actions
    
    @objc private func handleCloseButtonTapped() {
        onCloseButtonTapped?()
    }
    
    @objc private func handleConfirmButtonTapped() {
        onConfirmButtonTapped?()
    }
}
