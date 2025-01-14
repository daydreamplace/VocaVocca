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

class VocaModalViewController: UIViewController, CustomModalViewDelegate {
    
    // MARK: - Properties
    
    private let viewModel: VocaModalViewModel
    private let disposeBag = DisposeBag()
    private let modalView = CustomModalView(title: "새로운 단어 만들기", buttonTitle: "추가하기")
    
    private let selectVocaLabel: UILabel = {
        let label = UILabel()
        label.text = "단어장을 선택해 주세요 >"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .customBrown
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let wordTextFieldView = CustomTextFieldView(title: "단어", placeholder: "단어를 입력하세요")
    private let meaningTextFieldView = CustomTextFieldView(title: "뜻", placeholder: "뜻을 입력하세요")
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customDarkBrown
        button.layer.cornerRadius = 8
        return button
    }()
    
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
        setupActions()
        
        modalView.delegate = self
        viewModel.fetchVocaBookFromCoreData()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubviews(modalView, checkButton)
        
        modalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
            $0.bottom.equalToSuperview()
        }
        
        modalView.contentStackView.addArrangedSubviews(selectVocaLabel, wordTextFieldView, meaningTextFieldView)
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(wordTextFieldView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
    }
    
    private func bindViewModel() {
        // 단어 입력 텍스트 필드 바인딩
        wordTextFieldView.didEndEditing = { [weak self] text in
            self?.viewModel.word.accept(text)
        }
        
        // 뜻 입력 텍스트 필드 바인딩
        meaningTextFieldView.didEndEditing = { [weak self] text in
            self?.viewModel.meaning.accept(text)
        }
        
        // 확인 버튼 클릭 시 단어 번역
        checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        
        // 저장 버튼 동작
        modalView.confirmButton.rx.tap
            .bind { [weak self] in
                print("Confirm button tapped")
                self?.viewModel.handleSave()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVocaBook))
        selectVocaLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func selectVocaBook() {
        let vocaBookSelectVC = VocaBookSelectViewController()
        let navController = UINavigationController(rootViewController: vocaBookSelectVC)
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - CustomModalViewDelegate
    
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCheckButton() {
        let word = wordTextFieldView.textField.text ?? ""
        print("입력된 단어: \(word)")
        viewModel.fetchTranslation(for: word) // 뷰모델에서 fetchTranslation 호출
    }
}
