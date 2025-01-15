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
        label.text = "→ 단어장을 선택해주세요"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .customDarkBrown
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let wordTextFieldView: CustomTextFieldView
    private let meaningTextFieldView = CustomTextFieldView(title: "뜻", placeholder: "뜻을 입력하세요")
    
    let toastView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.layer.cornerRadius = 15
        view.isHidden = true
        return view
    }()

    let toastLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    // MARK: - Initialization
    
    init(viewModel: VocaModalViewModel) {
        self.viewModel = viewModel
        self.wordTextFieldView = CustomTextFieldView(title: "단어", placeholder: "단어를 입력하세요", showSearchButton: true)
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
        view.addSubview(modalView)
        view.addSubview(toastView)
        
        toastView.addSubview(toastLabel)
        
        modalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
            $0.bottom.equalToSuperview()
        }
        
        toastView.snp.makeConstraints {
            $0.width.equalTo(toastLabel.snp.width).multipliedBy(1.5)
            $0.height.equalTo(toastLabel.snp.height).multipliedBy(2)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(200)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        modalView.contentStackView.addArrangedSubviews(selectVocaLabel, wordTextFieldView, meaningTextFieldView)
        
        modalView.contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
        }
    }
    
    private func bindViewModel() {
        // 단어 입력 텍스트 필드
        wordTextFieldView.didEndEditing = { [weak self] text in
            self?.viewModel.wordValue = text
            self?.viewModel.word.accept(text)
        }
        
        // 뜻 입력 텍스트 필드
        meaningTextFieldView.textField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.meaningValue = text
                self?.viewModel.meaning.accept(text)
            })
            .disposed(by: disposeBag)
        
        // 검색 버튼 클릭 시 동작
        wordTextFieldView.searchButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                guard let self = self else { return }
                let word = self.wordTextFieldView.textField.text ?? ""
                self.viewModel.wordValue = word

                guard let lang = viewModel.thisVocaBook?.language else {
                    viewModel.createVocaError.onNext(CreateVocaError.noSelect)
                    return }
                guard let a =  Language(rawValue: lang) else {

                    return
                }
                self.viewModel.fetchTranslation(for: word, language: a)
            }
            .disposed(by: disposeBag)
        
        // 저장 버튼 동작
        modalView.confirmButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.meaningValue = self?.meaningTextFieldView.textField.text ?? ""
                self?.viewModel.wordValue = self?.wordTextFieldView.textField.text ?? ""
                self?.viewModel.checkStatus()
            }
            .disposed(by: disposeBag)
        
        viewModel.closeSubject
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.createVocaError
            .observe(on: MainScheduler.instance)
            .bind { [weak self] status in
                self?.checkStatus(status)
            }
            .disposed(by: disposeBag)
        
        // meaning을 바인딩
        viewModel.meaning
            .bind(to: meaningTextFieldView.textField.rx.text)
            .disposed(by: disposeBag)
        
        // 선택된 VocaBook 값 확인용 구독 추가
        viewModel.selectedVocaBook
            .subscribe(onNext: { book in
            })
            .disposed(by: disposeBag)
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVocaBook))
        selectVocaLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func selectVocaBook() {
        
        if viewModel.selectedVocaBook.value == nil {
            print("selectedVocaBook is nil")
        }
        let selectedVocaBookSubject = PublishSubject<VocaBookData>()
        
        viewModel.selectedVocaBook
            .compactMap { $0 }
            .bind(to: selectedVocaBookSubject)
            .disposed(by: disposeBag)
        
        let vocaBookSelectVM = VocaBookSelectViewModel(
            selectedVocaBook: selectedVocaBookSubject,
            closeSubject: viewModel.completeSubject
        )
        let vocaBookSelectVC = VocaBookSelectViewController(viewModel: vocaBookSelectVM)
        
        selectedVocaBookSubject
            .subscribe(onNext: { vocaBook in
                print("VocaBook selected in Subject: \(vocaBook)")
            })
            .disposed(by: disposeBag)
        
        selectedVocaBookSubject
            .map { vocaBook in "→ \(vocaBook.title ?? "")" }
            .bind(to: selectVocaLabel.rx.text)
            .disposed(by: disposeBag)
        
        selectedVocaBookSubject
            .bind { [weak self] vocabook in
                print("VocaBook received in ViewModel update: \(vocabook)")
                self?.viewModel.updateVocaBook(vocabook)
            }
            .disposed(by: disposeBag)
        
        let navController = UINavigationController(rootViewController: vocaBookSelectVC)
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - CustomModalViewDelegate
    
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // 선택 에러 상태 확인
    private func checkStatus(_ status: CreateVocaError) {
        switch status {
        case .noSelect: showToastMessage(status.text)
        case .noWord: showToastMessage(status.text)
        case .noMeaning: showToastMessage(status.text)
        case .noMatch: showToastMessage(status.text)
        }
    }
    
    
    // 토스트 메세지 보여주기
    private func showToastMessage(_ message: String) {
        print(message)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseIn, animations: {
            self.toastView.isHidden = false
            self.toastView.alpha = 0.0
            self.toastLabel.text = message
        }) { _ in
            self.toastView.isHidden = true
            self.toastView.alpha = 1

        }
    }
}
