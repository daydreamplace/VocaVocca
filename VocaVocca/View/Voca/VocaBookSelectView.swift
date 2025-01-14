//
//  VocaBookSelectView.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/9/25.
//

import UIKit
import SnapKit

final class VocaBookSelectView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 90)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(VocaBookSelectCell.self, forCellWithReuseIdentifier: VocaBookSelectCell.id)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 36)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customDarkBrown
        button.layer.cornerRadius = 25
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(collectionView, createButton)
        
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(60)
        }
        
        createButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(32)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.height.equalTo(50)
        }
    }
}
