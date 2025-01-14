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
        
        modalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
            $0.bottom.equalToSuperview()
        }
        
        languageContainerStackView.addArrangedSubviews(languageTitleLabel, languageStackView)
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
        
        textFieldView.textField.rx.text.orEmpty
            .bind(to: viewModel.vocaBookTitle)
            .disposed(by: disposeBag)
        
        viewModel.isSaveEnabled
            .bind(to: modalView.confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        modalView.confirmButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.handleSaveOrEdit()
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func languageButtonTapped(_ sender: UIButton) {
        guard let language = Language(rawValue: sender.titleLabel!.text!) else { return }
        
        viewModel.selectedLanguage(language)
        
        for button in languageStackView.arrangedSubviews.compactMap({ $0 as? UIButton }) {
            button.backgroundColor = .lightGray
        }
        sender.backgroundColor = .customDarkBrown
    }
    
    // MARK: - CustomModalViewDelegate
    
    func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}
