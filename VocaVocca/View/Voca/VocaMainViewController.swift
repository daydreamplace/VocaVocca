//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class VocaMainViewController: UIViewController {
    
    // MARK: - Properties
    private let showModalButton: UIButton = {
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
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(showModalButton)
        
        showModalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showModalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showModalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showModalButton.widthAnchor.constraint(equalToConstant: 120),
            showModalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        showModalButton.addTarget(self, action: #selector(showModalButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func showModalButtonTapped() {
        let modalViewController = VocaBookModalViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.modalTransitionStyle = .crossDissolve
        present(modalViewController, animated: true, completion: nil)
    }
}


