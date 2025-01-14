//
//  LearningResultViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LearningResultViewController: UIViewController {
    
    private let learningResultView = LearningResultView()
    private let viewModel: LearningResultViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: LearningResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = learningResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // 정답 갯수 바인딩
        viewModel.correctCount
            .map { "정답 \($0)" }
            .bind(to: learningResultView.correctCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 오답 갯수 바인딩
        viewModel.inCorrectCount
            .map { "오답 \($0)" }
            .bind(to: learningResultView.incorrectCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 정답률 바인딩
        viewModel.correctRate
            .map { "정답률 \($0)%" }
            .bind(to: learningResultView.correctRateLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 커피콩 개수 바인딩
        viewModel.filledBeanCount
            .subscribe(onNext: { [weak self] filledCount in
                self?.learningResultView.updateCoffeeBeans(correctCount: filledCount)
            })
            .disposed(by: disposeBag)
        
        // 닫기 서브젝트 바인딩
        viewModel.closeSubject
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.closeModal()
            }
            .disposed(by: disposeBag)
        
        // 닫기 버튼 클릭 바인딩
        learningResultView.closeButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.closeAction()
            }
            .disposed(by: disposeBag)
    }
    
    // 모달 닫기
    private func closeModal() {
        dismiss(animated: true, completion: nil)
    }
}
