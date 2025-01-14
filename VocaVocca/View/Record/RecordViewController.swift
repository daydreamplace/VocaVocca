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
    private let viewModel = RecordViewModel()
    
    override func loadView() {
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setUpNaviBar()
        
        // 데이터 바인딩 확인
        viewModel.todayCorrectWords
            .map { "\($0.count)" }
            .bind(to: recordView.correctCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.todayIncorrectWords
            .map { "\($0.count)" }
            .bind(to: recordView.incorrectCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTodayRecords()
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
                let resultVC = RecordResultViewController(
                    correctWords: self.viewModel.todayCorrectWords.map { $0.map { ($0.word ?? "", $0.meaning ?? "") } },
                    incorrectWords: self.viewModel.todayIncorrectWords.map { $0.map { ($0.word ?? "", $0.meaning ?? "") } }
                )
                resultVC.showCorrectWords()
                self.navigationController?.pushViewController(resultVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        // Incorrect 버튼 클릭 시
        recordView.incorrectButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let resultVC = RecordResultViewController(
                    correctWords: self.viewModel.todayCorrectWords.map { $0.map { ($0.word ?? "", $0.meaning ?? "") } },
                    incorrectWords: self.viewModel.todayIncorrectWords.map { $0.map { ($0.word ?? "", $0.meaning ?? "") } }
                )
                resultVC.showIncorrectWords()
                self.navigationController?.pushViewController(resultVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
