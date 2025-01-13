//
//  LearningView.swift
//  VocaVocca
//
//  Created by t2023-m0033 on 1/10/25.
//

import UIKit
import SnapKit

final class LearningView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        // 열 간격 + 좌우 inset 합 = 여백크기
        let totalSpacing: CGFloat = 20 + 16 * 2
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(LearningViewCell.self, forCellWithReuseIdentifier: LearningViewCell.id)
        return collectionView
    }()
    
    let startButton: CustomButton = {
        let button = CustomButton(title: "시작하기")
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
        addSubviews(collectionView, startButton)
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-100)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
    }
}
