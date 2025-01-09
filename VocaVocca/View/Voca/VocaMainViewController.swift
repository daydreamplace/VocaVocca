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
        view.backgroundColor = .brown // 배경 색 설정
        
        // 모달을 열기 위한 버튼 생성
        let showModalButton = UIButton(type: .system)
        showModalButton.setTitle("모달 열기", for: .normal)
        showModalButton.setTitleColor(.white, for: .normal)
        showModalButton.backgroundColor = .darkGray
        showModalButton.layer.cornerRadius = 10
        showModalButton.addTarget(self, action: #selector(showModal), for: .touchUpInside)
        
        // 버튼 추가
        view.addSubview(showModalButton)
        showModalButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    @objc private func showModal() {
        // CustomModalView 생성
        let modalView = CustomModalView(
            title: "테스트 모달",
            buttonTitle: "확인",
            action: { print("확인 버튼이 눌렸습니다!") } // 버튼 동작 설정
        )
        
        modalView.onCloseButtonTapped = { [weak modalView] in
            print("모달 닫기 버튼이 눌렸습니다!")
            modalView?.removeFromSuperview() // 모달 제거
        }
        
        // 화면에 추가
        view.addSubview(modalView)
        
        // SnapKit으로 레이아웃 설정
        modalView.snp.makeConstraints { make in
            make.leading.equalToSuperview() // 왼쪽 끝에 맞춤
            make.trailing.equalToSuperview() // 오른쪽 끝에 맞춤
            make.height.equalToSuperview().multipliedBy(0.9) // 높이를 화면의 80%로 설정
            make.bottom.equalToSuperview() // 아래쪽 끝에 붙임
        }
    }
}
