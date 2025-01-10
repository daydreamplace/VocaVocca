//
//  RecordView.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/10/25.
//

import UIKit
import SnapKit

final class RecordView: UIView {
    
    private let correctView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
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
    
    private let incorrectView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
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
        correctView.addSubviews(correctLabel, correctCountLabel)
        incorrectView.addSubviews(incorrectLabel, incorrectCountLabel)
        addSubviews(correctView, incorrectView)
        
        correctView.snp.makeConstraints {
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
        
        incorrectView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(correctView.snp.bottom).offset(60)
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
}