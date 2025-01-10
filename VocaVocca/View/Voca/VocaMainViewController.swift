//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class VocaMainViewController: UIViewController {
    
    // MARK: - UI Components
    private let openModalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("모달 열기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // 버튼 추가
        view.addSubview(openModalButton)
        
        // 버튼 제약 조건 설정
        openModalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openModalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openModalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openModalButton.widthAnchor.constraint(equalToConstant: 120),
            openModalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        // 버튼 클릭 액션 추가
        openModalButton.addTarget(self, action: #selector(openModalButtonTapped), for: .touchUpInside)
    }
    
    @objc private func openModalButtonTapped() {
        // VocaBookModalViewController 모달 띄우기
        let modalViewController = VocaBookModalViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.modalTransitionStyle = .crossDissolve
        present(modalViewController, animated: true, completion: nil)
    }
}

