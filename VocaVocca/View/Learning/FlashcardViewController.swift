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
        flashcardViewModel.isCoachMarkDisabled
            .filter { $0 == false }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.connectCoachmarkModal()
            })
            .disposed(by: disposeBag)
        
        flashcardViewModel.currentVoca
            .map { $0?.word }
            .bind(to: flashcardView.wordLabel.rx.text)
            .disposed(by: disposeBag)
        
        flashcardViewModel.currentIndex
            .map { "\($0 + 1)" }
            .bind(to: flashcardView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        flashcardViewModel.totalVocaCount
            .map { "\($0)" }
            .bind(to: flashcardView.totalCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        flashcardViewModel.isLastVoca
            .filter { $0 }
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.connectResultModal()
                self.flashcardViewModel.saveResults()
            }
            .disposed(by: disposeBag)
        
        flashcardView.closeButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.closeButtonTapped()
            }
            .disposed(by: disposeBag)
                
        flashcardView.gotItButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.flashcardViewModel.markWordAsCorrect()
            }
            .disposed(by: disposeBag)
        
        flashcardView.notYetButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.flashcardViewModel.markWordsAsIncorrect()
            }
            .disposed(by: disposeBag)
    }
    
    private func connectCoachmarkModal() {
        let coachmarkVC = CoachmarkViewController()
        coachmarkVC.modalPresentationStyle = .overFullScreen
        present(coachmarkVC, animated: false)
    }
    
    private func connectResultModal() {
        let learningResultVC = LearningResultViewController()
        learningResultVC.modalPresentationStyle = .overFullScreen
        present(learningResultVC, animated: true)
    }
    
    private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
