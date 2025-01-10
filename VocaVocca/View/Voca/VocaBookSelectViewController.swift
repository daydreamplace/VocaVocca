//
//  VocaBookSelectViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class VocaBookSelectViewController: UIViewController {
    
    private let vocaBookSelectView = VocaBookSelectView()
    
    override func loadView() {
        self.view = vocaBookSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setUpNaviBar()
    }
    
    private func setupCollectionView() {
        vocaBookSelectView.collectionView.dataSource = self
        vocaBookSelectView.collectionView.delegate = self
    }
    
    private func setUpNaviBar() {
        title = "단어장 선택"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = .customBlack
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .customBrown
    }
    
    @objc private func doneButtonTapped() {
        print(#function)
        dismiss(animated: true)
    }
}

extension VocaBookSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VocaBookSelectCell.id, for: indexPath) as? VocaBookSelectCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension VocaBookSelectViewController: UICollectionViewDelegate {
    
}
