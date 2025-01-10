//
//  LearningViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class LearningViewController: UIViewController {
    
    private let learningView = LearningView()
    
    override func loadView() {
        self.view = learningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActions()
    }
    
    private func setupCollectionView() {
        learningView.collectionView.dataSource = self
        learningView.collectionView.delegate = self
    }
    
    ///TODO - 뷰에 있는 버튼 로직 처리
    private func setupActions() {
        learningView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        // 플래시카드뷰 띄우기
        let flashcardVC = FlashcardViewController()
        flashcardVC.modalPresentationStyle = .fullScreen
        present(flashcardVC, animated: false)
    }
}

// MARK: - UICollectionViewDataSource

extension LearningViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LearningViewCell.id, for: indexPath) as? LearningViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension LearningViewController: UICollectionViewDelegate {
    
}
