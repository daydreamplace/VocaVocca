//
//  RecordView.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/10/25.
//

import UIKit
import SnapKit

final class RecordView: UIView {
    
    let correctButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let correctLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "오늘 암기한 단어"
        return label
    }()
    
    private let correctCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textAlignment = .center
        label.text = "15"
        label.textColor = .systemBlue
        return label
    }()
    
    let incorrectButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let incorrectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "오늘 틀린 단어"
        return label
    }()
    
    private let incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textAlignment = .center
        label.text = "15"
        label.textColor = .systemRed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        correctButton.addSubviews(correctLabel, correctCountLabel)
        incorrectButton.addSubviews(incorrectLabel, incorrectCountLabel)
        addSubviews(correctButton, incorrectButton)
        
        correctButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            $0.height.equalTo(160)
        }
        
        correctLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview()
        }
        
        correctCountLabel.snp.makeConstraints {
            $0.top.equalTo(correctLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        incorrectButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(correctButton.snp.bottom).offset(60)
            $0.height.equalTo(160)
        }
        
        incorrectLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview()
        }
        
        incorrectCountLabel.snp.makeConstraints {
            $0.top.equalTo(incorrectLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Button Actions
    
    func addCorrectButtonAction(target: Any, action: Selector) {
        correctButton.addTarget(target, action: action, for: .touchUpInside)

    }
    
    func addIncorrectButtonAction(target: Any, action: Selector) {
        incorrectButton.addTarget(target, action: action, for: .touchUpInside)
        
    }
}

