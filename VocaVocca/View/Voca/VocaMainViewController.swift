//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class VocaMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        // CustomTextFieldView 인스턴스 생성
        let customTextField = CustomTextFieldView(title: "단어장 이름", placeholder: "입력해주세요")
        
        // 텍스트필드 추가 및 레이아웃 설정
        view.addSubview(customTextField)
        customTextField.snp.makeConstraints { make in
            make.center.equalToSuperview() // 화면 중앙에 배치
            make.leading.trailing.equalToSuperview().inset(16) // 좌우 여백
        }
    }
    
    
}

