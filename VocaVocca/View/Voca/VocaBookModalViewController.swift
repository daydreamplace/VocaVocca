//
//  VocaBookModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift

class VocaBookModalViewController: UIViewController, CustomModalViewDelegate {
    
    // MARK: - Properties
    
    private let viewModel: VocaBookModalViewModel
    private let disposeBag = DisposeBag()
    
    private let modalView = CustomModalView(title: "", buttonTitle: "")
    private let textFieldView = CustomTextFieldView(title: "단어장 이름", placeholder: "입력해주세요.")
    
    private let languageContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let languageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "언어"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .brown
        return label
    }()
    
    private let languageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
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
    
    private let availableLanguages: [Language] = [.english, .chinese, .japanese, .german, .spanish]
    
    // MARK: - Initialization
    
    init(viewModel: VocaBookModalViewModel) {
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
        setupLanguageButtons()
        bindViewModel()
        modalView.delegate = self
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
        
        languageContainerStackView.addArrangedSubviews(languageTitleLabel, languageStackView)
        
        toastView.snp.makeConstraints {
            $0.width.equalTo(toastLabel.snp.width).multipliedBy(1.5)
            $0.height.equalTo(toastLabel.snp.height).multipliedBy(2)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(200)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        modalView.contentStackView.addArrangedSubviews(textFieldView, languageContainerStackView)
    }
    
    private func setupLanguageButtons() {
        for (index, language) in (availableLanguages.enumerated()) {
            let lang = Language.allCases
            let button = createLanguageButton(for: language)
            languageStackView.addArrangedSubview(button)
        }
    }
    
    private func createLanguageButton(for language: Language) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(language.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(languageButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - bind
    
    private func bindViewModel() {
        viewModel.title
            .bind(to: modalView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.buttonTitle
            .bind(to: modalView.confirmButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
//        textFieldView.textField.rx.text.orEmpty
//            .bind(to: viewModel.vocaBookTitle)
//            .disposed(by: disposeBag)
//        
//        viewModel.isSaveEnabled
//            .bind(to: modalView.confirmButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        modalView.confirmButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.vocaBookName = self?.textFieldView.textField.text ?? ""
                self?.viewModel.checkStatus()
                //self?.viewModel.handleSaveOrEdit()
                //self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.createVocaBookError
            .bind { [weak self] status in
                self?.viewModel.vocaBookName = self?.textFieldView.textField.text ?? ""
                self?.checkStatus(status)
            }
            .disposed(by: disposeBag)
        
        viewModel.saveCompleted
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func languageButtonTapped(_ sender: UIButton) {
        guard let language = Language(rawValue: sender.titleLabel!.text!) else { return }
        
        viewModel.selectedLanguage(language)
        viewModel.language = language.title
        
        for button in languageStackView.arrangedSubviews.compactMap({ $0 as? UIButton }) {
            button.backgroundColor = .lightGray
        }
        sender.backgroundColor = .customDarkBrown
    }
    
    // MARK: - CustomModalViewDelegate
    
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // 선택 에러 상태 확인
    private func checkStatus(_ status: CreateVocaBookError) {
        switch status {
        case .noVocaBook: showToastMessage(status.text)
        case .noLanguage: showToastMessage(status.text)
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
