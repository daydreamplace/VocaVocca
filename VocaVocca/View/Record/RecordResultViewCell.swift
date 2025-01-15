//
//  RecordResultViewCell.swift
//  VocaVocca
//
//  Created by 강민성 on 1/13/25.
//

import UIKit
import SnapKit

class RecordResultViewCell: UITableViewCell {
    
    static let id = "RecordResultViewCell"
    
    let statusTag = CustomTagView()
    let languageTag = CustomTagView()
    let cardView = CustomCardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        // 태그 추가
        cardView.addSubviews(statusTag, languageTag)
        
        statusTag.snp.makeConstraints {
            $0.width.equalTo(35)
            $0.leading.equalTo(cardView.wordLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        languageTag.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.leading.equalTo(statusTag.snp.trailing).offset(8)
            $0.centerY.equalTo(statusTag)
            $0.height.equalTo(20)
        }
    }
    
    func configureCell(isCorrect: Bool) {
        let statusText = isCorrect ? "정답" : "오답"
        let statusColor = isCorrect ? UIColor.systemBlue : UIColor.systemRed
        
        // 정답/오답 태그 설정
        statusTag.setTagView(color: statusColor, label: statusText)
        
        // 내부 배경색 설정
        if let backgroundView = statusTag.subviews.first {
            backgroundView.backgroundColor = statusColor // 내부 배경색 설정
        }
        
        // 언어 태그 설정
        if let backgroundView = languageTag.subviews.first {
            backgroundView.backgroundColor = .systemGray2
        }
    }
}
