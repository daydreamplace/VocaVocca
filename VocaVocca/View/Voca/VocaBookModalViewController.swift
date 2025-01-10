//
//  VocaBookModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class VocaBookModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private let modalView = CustomModalView(title: "새로운 단어장 만들기", buttonTitle: "생성하기")
    private let textFieldView = CustomTextFieldView(title: "단어장 이름", placeholder: "단어장 이름을 지어주세요")
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupElementsInModalContent()
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
        modalView.contentStackView.addArrangedSubviews(textFieldView)
    }
}
