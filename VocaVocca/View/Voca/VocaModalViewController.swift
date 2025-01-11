//
//  VocaModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class VocaModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private let modalView = CustomModalView(title: "새로운 단어 만들기", buttonTitle: "추가하기")
    private let wordTextFieldView = CustomTextFieldView(title: "단어", placeholder: "단어를 입력하세요")
    private let meaningTextFieldView = CustomTextFieldView(title: "뜻", placeholder: "뜻을 입력하세요")
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        
        modalView.contentStackView.addArrangedSubview(wordTextFieldView)
        modalView.contentStackView.addArrangedSubview(meaningTextFieldView)
    }
    
}
