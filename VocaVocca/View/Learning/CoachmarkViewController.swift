//
//  CoachmarkViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift
import RxCocoa

class CoachmarkViewController: UIViewController {
    
    let coachmarkView = CoachmarkView()
    let coachmarkViewModel = CoachmarkViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - 생명주기 메서드
    
    override func loadView() {
        view = coachmarkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    // MARK: - 레이아웃 설정
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6) // 투명도 설정
    }
    
    // MARK: - bind
    
    private func bind() {
        coachmarkViewModel.isSelected
            .bind(to: coachmarkView.skipCheckboxButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        coachmarkView.closeButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.closeButtonTapped()
            }
            .disposed(by: disposeBag)
        
        coachmarkView.skipCheckboxButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.coachmarkViewModel.toggleSelection()
            }
            .disposed(by: disposeBag)
    }
    
    private func closeButtonTapped() {
        if coachmarkView.skipCheckboxButton.isSelected {
            coachmarkViewModel.setCoachMarkDisabled()
        }
        dismiss(animated: true)
    }
}
