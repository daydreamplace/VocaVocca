//
//  RecordViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RecordViewController: UIViewController {
    
    private let recordView = RecordView()
    private let disposeBag = DisposeBag()
    
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
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupActions() {
        // Correct 버튼 클릭 시
        recordView.correctButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let resultVC = RecordResultViewController()
                resultVC.showCorrectWords()
                self.navigationController?.pushViewController(resultVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        // Incorrect 버튼 클릭 시
        recordView.incorrectButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let resultVC = RecordResultViewController()
                resultVC.showIncorrectWords()
                self.navigationController?.pushViewController(resultVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
