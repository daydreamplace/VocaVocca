//
//  VocaMainTableViewCell.swift
//  VocaVocca
//
//  Created by 안준경 on 1/9/25.
//

import UIKit
import SnapKit

class VocaMainTableViewCell: UITableViewCell {
    
    static let id = "VocaMainTableViewCell"
    
    let cardView = CustomCardView()
    let customTag = CustomTagView()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        customTag.subviews.first?.backgroundColor = .lightGray
        customTag.setTagView(layerColor: .lightGray, label: "영어", textColor: .white)
        
        cardView.addSubviews(customTag, removeButton)
        addSubviews(cardView)
        
        cardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        customTag.snp.makeConstraints {
            $0.bottom.equalTo(cardView.snp.bottom).offset(120)
            $0.leading.equalTo(cardView.snp.leading).inset(-150)
            $0.width.equalTo(45)
            $0.height.equalTo(20)
        }
        
        removeButton.snp.makeConstraints {
            $0.bottom.equalTo(cardView.snp.bottom).offset(120)
            $0.trailing.equalTo(cardView.snp.trailing).offset(150)
            $0.width.height.equalTo(20)
        }
    }
}

