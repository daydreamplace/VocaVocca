//
//  CustomTagView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class CustomTagView: UIView {
    
    private let tagBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
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
        addSubview(tagBackgroundView)
        tagBackgroundView.addSubview(tagLabel)
        
        tagBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /// 컬러, 레이블 설정
    func setTagView(color: UIColor, label title: String) {
        tagBackgroundView.backgroundColor = color
        tagLabel.text = title
    }
}
