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
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let contenStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Action Closures
    
    var onCloseButtonTapped: (() -> Void)?
    var onConfirmButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    
    init(title: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.confirmButton.setTitle(buttonTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Actions
    
    @objc private func handleCloseButtonTapped() {
        onCloseButtonTapped?()
    }
    
    @objc private func handleConfirmButtonTapped() {
        onConfirmButtonTapped?()
    }
}
