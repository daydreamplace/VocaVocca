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
    let flashcardViewModel = FlashcardViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - 생명주기 메서드
    
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
        flashcardViewModel.subject
            .filter { $0 == false }
            .subscribe(onNext: { [weak self] _ in
                self?.connectModal()
                
            })
            .disposed(by: disposeBag)
        flashcardViewModel.isCoachMarkDisabled()
        
        flashcardView.closeButton.rx.tap
            .bind { [weak self] in
                self?.closeButtonTapped()
            }
    }
    
    private func connectModal() {
        let coachmarkVC = CoachmarkViewController()
        coachmarkVC.modalPresentationStyle = .overFullScreen
        present(coachmarkVC, animated: false)
    }
    
    private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
