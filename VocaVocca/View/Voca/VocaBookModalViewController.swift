//
//  VocaBookModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import UIKit
import SnapKit

class VocaBookModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private let modalView = CustomModalView(title: "새로운 단어장 만들기", buttonTitle: "추가하기")

    private let textFieldView = CustomTextFieldView(title: "단어장 이름", placeholder: "단어장 이름을 지어주세요")

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
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
    private var selectedLanguage: Language = .english

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupElementsInModalContent()
        setupLanguageStackview()
    }

    // MARK: - Setup

    private func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(modalView)

        modalView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.85)
            $0.bottom.equalToSuperview()
        }
    }

    private func setupElementsInModalContent() {
        languageContainerStackView.addArrangedSubviews(languageTitleLabel, languageStackView)
        modalView.contentStackView.addArrangedSubviews(textFieldView, languageContainerStackView)
    }

    private func setupLanguageStackview() {
        for language in availableLanguages {
            let button = createLanguageButton(for: language)
            languageStackView.addArrangedSubview(button)
        }
    }

    private func createLanguageButton(for language: Language) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(language.koreanTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = (language == selectedLanguage) ? .brown : .lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = language.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false

        button.snp.makeConstraints {
            $0.height.equalTo(40)
        }

        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true

        button.addTarget(self, action: #selector(languageButtonTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func languageButtonTapped(_ sender: UIButton) {
        guard let language = Language(rawValue: sender.tag) else { return }
        selectedLanguage = language
        updateLanguageButtons()
    }

    private func updateLanguageButtons() {
        for button in languageStackView.arrangedSubviews {
            guard let button = button as? UIButton else { continue }
            guard let language = Language(rawValue: button.tag) else { continue }
            button.backgroundColor = (language == selectedLanguage) ? .brown : .lightGray
        }
    }
}
