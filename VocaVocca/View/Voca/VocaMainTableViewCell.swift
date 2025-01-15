//
//  VocaMainTableViewCell.swift
//  VocaVocca
//
//  Created by 안준경 on 1/9/25.
//

import UIKit
import SnapKit
import RxSwift

class VocaMainTableViewCell: UITableViewCell {
    
    static let id = "VocaMainTableViewCell"
    
    let cardView = CustomCardView()
    let customTag = CustomTagView()
    
    var disposeBag = DisposeBag()
    
    let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // 기존 바인딩 초기화
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        cardView.addSubviews(customTag, removeButton)
        addSubviews(cardView)
        
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(340)
            $0.height.equalTo(140)
        }
        
        customTag.snp.makeConstraints {
            $0.bottom.equalTo(cardView.snp.bottom).inset(20)
            $0.leading.equalTo(cardView.snp.leading).inset(20)
            $0.width.equalTo(45)
            $0.height.equalTo(20)
        }
        
        removeButton.snp.makeConstraints {
            $0.bottom.equalTo(cardView.snp.bottom).inset(16)
            $0.trailing.equalTo(cardView.snp.trailing).inset(16)
            $0.width.height.equalTo(30)
        }
    }
}

