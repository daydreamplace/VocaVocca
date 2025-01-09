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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let meanLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        cardBackgroundView.addSubviews(wordLabel, meanLabel, removeButton)
        addSubview(cardBackgroundView)
                
        cardBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(140)
        }
        
        wordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalTo(cardBackgroundView.snp.leading).inset(20)
        }
        
        meanLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.trailing.equalTo(cardBackgroundView.snp.trailing).inset(20)
        }
        
        removeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
}

