//
//  LearningViewCell.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/8/25.
//

import UIKit
import SnapKit

final class LearningViewCell: UICollectionViewCell {
    
    static let id = "LearningViewCell"
    
    // 셀 선택 시 배경색 변경
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.customLightBrown : UIColor.white
        }
    }
    
    private let tagView: CustomTagView = {
        let view = CustomTagView()
        view.setTagView(layerColor: UIColor.customBrown, label: "영어", textColor: UIColor.customBrown)
        return view
    }()
    
    private let vocaBookLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.text = "단어장"
        label.textAlignment = .center
        return label
    }()
    
    private let vocaCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "14개"
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubviews(tagView, vocaBookLabel, vocaCountLabel)
        
        tagView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        vocaBookLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        vocaCountLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(8)
        }
    }
}
