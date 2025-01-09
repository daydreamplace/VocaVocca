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
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
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
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 20
        
        headerStackView.addArrangedSubviews(titleLabel, spacerView, closeButton)
        addSubviews(headerStackView, contentStackView, confirmButton)
        
        headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-32)
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
