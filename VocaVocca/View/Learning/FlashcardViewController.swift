//
//  FlashcardViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class FlashcardViewController: UIViewController {
    
    // MARK: - UI 컴포넌트
    
    let flashcardView = FlashcardView()
    let flashcardViewModel: FlashcardViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - 생명주기 메서드
    
    init(viewModel: FlashcardViewModel) {
        self.flashcardViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = flashcardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - bind
    
    private func bind() {
        // 코치마크 비활성화 여부 바인딩
        flashcardViewModel.isCoachMarkDisabled
            .filter { $0 == false }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.connectCoachmarkModal()
            })
            .disposed(by: disposeBag)
        
        // 현재 단어 바인딩
        flashcardViewModel.currentVoca
            .map { $0?.word }
            .bind(to: flashcardView.wordLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 현재 인덱스 바인딩
        flashcardViewModel.currentIndex
            .map { "\($0 + 1)" }
            .bind(to: flashcardView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 보카 단어 수 바인딩
        flashcardViewModel.totalVocaCount
            .map { "\($0)" }
            .bind(to: flashcardView.totalCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 학습 결과 바인딩
        flashcardViewModel.learningResult
            .bind { [weak self] result in
                guard let self = self else { return }
                self.connectLearningResultModal(result)
            }
            .disposed(by: disposeBag)
        
        // 닫기 버튼 클릭 바인딩
        flashcardView.closeButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.closeButtonTapped()
            }
            .disposed(by: disposeBag)
        
        // 알아요 버튼 클릭 바인딩
        flashcardView.gotItButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.flashcardViewModel.markWordAsCorrect()
            }
            .disposed(by: disposeBag)
        
        // 잘몰라요 버튼 클릭 바인딩
        flashcardView.notYetButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.flashcardViewModel.markWordsAsIncorrect()
            }
            .disposed(by: disposeBag)
        
        // 플래시카드뷰 스와이프 바인딩
        flashcardView.flashcardView.rx
            .swipeGesture([.left, .right])
            .skip(2)
            .bind { [weak self] gesture in
                guard let self = self else { return }
                if gesture.direction == .left {
                    self.flashcardViewModel.markWordsAsIncorrect()
                } else {
                    self.flashcardViewModel.markWordsAsIncorrect()
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 코치마크 모달 연결
    private func connectCoachmarkModal() {
        let coachmarkVC = CoachmarkViewController()
        coachmarkVC.modalPresentationStyle = .overFullScreen
        present(coachmarkVC, animated: false)
    }
    
    // 결과 모달 연결
    private func connectLearningResultModal(_ result: LearningResult) {
        let learningResultVM = LearningResultViewModel(learningResult: result)
        let learningResultVC = LearningResultViewController(viewModel: learningResultVM)
        learningResultVC.modalPresentationStyle = .overFullScreen
        present(learningResultVC, animated: true)
        
        // 닫기 서브젝트 바인딩
        learningResultVM.closeSubject
            .bind { [weak self] _ in
                self?.closeModal()
            }
            .disposed(by: disposeBag)
    }
    
    // 닫기 버튼 클릭
    private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 모달 닫기
    private func closeModal() {
        navigationController?.popToRootViewController(animated: true)
    }
}
