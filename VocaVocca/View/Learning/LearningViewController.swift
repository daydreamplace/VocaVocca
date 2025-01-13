//
//  LearningViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LearningViewController: UIViewController {
    
    private let learningView = LearningView()
    private let disposeBag = DisposeBag()
    private let viewModel = LearningViewModel()
    
    override func loadView() {
        self.view = learningView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        viewModel.addTestVocaBooks()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    // 네비바 설정
    private func setUpNaviBar() {
        title = "플래시 카드"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = .customBlack
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // 테이블 뷰에 데이터 바인딩
    private func bind() {
        viewModel.vocaBookSubject
            .observe(on: MainScheduler.instance)
            .bind(to: learningView.collectionView.rx.items(cellIdentifier: LearningViewCell.id, cellType: LearningViewCell.self)) {
                index, item, cell in
                
                cell.vocaBookLabel.text = item.title
                
                /// TODO - 태그 언어 관련 고민
                cell.tagView.setTagView(layerColor: UIColor.customBrown, label: "영어", textColor: UIColor.customBrown)
                cell.vocaCountLabel.text = "\(item.words?.count ?? 0) 개"
            }.disposed(by: disposeBag)
        
        // 선택된 셀 데이터
        learningView.collectionView.rx.modelSelected(VocaBookData.self)
            .subscribe(onNext: { [weak self] selectedBook in
                self?.viewModel.selectedVocaBook = selectedBook
            })
            .disposed(by: disposeBag)
        
        // 버튼 액션 바인딩
        learningView.startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToFlashCard()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToFlashCard() {
        guard let selectedBook = self.viewModel.selectedVocaBook else { return }
        
        let flashCardVM = FlashcardViewModel(data: selectedBook)
        let flashcardVC = FlashcardViewController(viewModel: flashCardVM)
        self.navigationController?.pushViewController(flashcardVC, animated: true)
    }
}
