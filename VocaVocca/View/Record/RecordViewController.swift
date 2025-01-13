//
//  RecordViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class RecordViewController: UIViewController {
    
    private let recordView = RecordView()
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setUpNaviBar()
    }
    
    private func setUpNaviBar() {
        title = "학습 기록"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = .customBlack
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupActions() {
        // 오늘 암기한 단어 버튼 액션
        recordView.addCorrectButtonAction(target: self, action: #selector(correctButtonTapped))
        
        // 오늘 틀린 단어 버튼 액션
        recordView.addIncorrectButtonAction(target: self, action: #selector(incorrectButtonTapped))
    }
    
    @objc private func correctButtonTapped() {
        let resultVC = RecordResultViewController()
        resultVC.showCorrectWords()
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    @objc private func incorrectButtonTapped() {
        let resultVC = RecordResultViewController()
        resultVC.showIncorrectWords()
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
