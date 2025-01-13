//
//  VocaModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VocaModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: VocaModalViewModel
    private let disposeBag = DisposeBag()
    private let modalView = CustomModalView(title: "새로운 단어 만들기", buttonTitle: "추가하기")
    
    private let selectVocaLabel: UILabel = {
        let label = UILabel()
        label.text = "단어장을 선택해 주세요 >"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .customBrown
        return label
    }()
    
    private let wordTextFieldView = CustomTextFieldView(title: "단어", placeholder: "단어를 입력하세요")
    private let meaningTextFieldView = CustomTextFieldView(title: "뜻", placeholder: "뜻을 입력하세요")
    
    // MARK: - Initialization
    
    init(viewModel: VocaModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(modalView)
        
        modalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
            $0.bottom.equalToSuperview()
        }
        
        modalView.contentStackView.addArrangedSubviews(selectVocaLabel, wordTextFieldView, meaningTextFieldView)
    }
    
    private func bindViewModel() {
        // 제목과 버튼 텍스트 바인딩
        viewModel.title
            .bind(to: modalView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.buttonTitle
            .bind { [weak self] title in
                self?.modalView.confirmButton.setTitle(title, for: .normal)
            }
            .disposed(by: disposeBag)
        
        // 텍스트 필드 바인딩
        wordTextFieldView.textField.rx.text.orEmpty
            .bind(to: viewModel.word)
            .disposed(by: disposeBag)
        
        meaningTextFieldView.textField.rx.text.orEmpty
            .bind(to: viewModel.meaning)
            .disposed(by: disposeBag)
        
        // 저장 버튼 활성화 상태
        viewModel.isSaveEnabled
            .bind(to: modalView.confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // 저장 버튼 동작
        modalView.confirmButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.handleSave()
            }
            .disposed(by: disposeBag)
    }
}
