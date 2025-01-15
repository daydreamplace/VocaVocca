//
//  CustomCardView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class CustomCardView: UIView {
    
    let cardBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor.customBlack
        return label
    }()
    
    let meanLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.customBlack
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
        cardBackgroundView.addSubviews(wordLabel, meanLabel)
        addSubview(cardBackgroundView)
        
        cardBackgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(140)
        }
        
        wordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        meanLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
//            $0.centerY.equalTo(wordLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
}

