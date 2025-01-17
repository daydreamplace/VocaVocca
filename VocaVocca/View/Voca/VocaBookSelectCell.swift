//
//  VocaBookSelectCell.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/9/25.
//

import UIKit
import SnapKit
import RxSwift

final class VocaBookSelectCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    static let id = "VocaBookSelectCell"
    
    // 셀 선택 시 테두리 색칠
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 3 : 1
            contentView.layer.borderColor = isSelected ? UIColor.customDarkerBrown.cgColor : UIColor.gray.cgColor
        }
    }
    
    // 셀 재사용시 DisposeBag 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    let vocaBookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .customBlack
        return label
    }()
    
    let wordsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let deleteButton: UIButton = {
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
