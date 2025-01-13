//
//  VocaMainTableViewCell.swift
//  VocaVocca
//
//  Created by t2023-m0072 on 1/9/25.
//

import UIKit
import SnapKit

class VocaMainTableViewCell: UITableViewCell {
    
    static let id = "VocaMainTableViewCell"
    
    private let cardView = CustomCardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupUI()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
    }
    
    func configureCell() {
        cardView.meanLabel.text = "검정색"
        cardView.wordLabel.text = "black"
    }
}
