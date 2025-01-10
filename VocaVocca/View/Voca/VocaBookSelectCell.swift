//
//  VocaBookSelectCell.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/9/25.
//

import UIKit
import SnapKit

final class VocaBookSelectCell: UICollectionViewCell {
    
    static let id = "VocaBookSelectCell"
    
    // 셀 선택 시 배경색 변경
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.customLightBrown : UIColor.white
        }
    }
    
    private let vocaBookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .customBlack
        label.text = "토익"
        return label
    }()
    
    private let wordsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = "단어 8개"
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let deleteButton: UIButton = {
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
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 14
        
        labelStackView.addArrangedSubviews(vocaBookNameLabel, wordsCountLabel)
        contentView.addSubviews(labelStackView, deleteButton)
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
