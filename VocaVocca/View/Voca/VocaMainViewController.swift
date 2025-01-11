//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift

class VocaMainViewController: UIViewController {

    private let vocaMainView = VocaMainView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupModalButton()
    }

    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.dataSource = self
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
    }

    private func setupModalButton() {
        // 모달 버튼 추가
        let modalButton = UIButton(type: .system)
        modalButton.setTitle("단어 추가", for: .normal)
        modalButton.setTitleColor(.white, for: .normal)
        modalButton.backgroundColor = .systemBlue
        modalButton.layer.cornerRadius = 10
        modalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(modalButton)

        // 모달 버튼 레이아웃
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            modalButton.widthAnchor.constraint(equalToConstant: 120),
            modalButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // 모달 버튼 동작 연결
        modalButton.addTarget(self, action: #selector(presentVocaModal), for: .touchUpInside)
    }

    @objc private func presentVocaModal() {
        let modalViewController = VocaModalViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.modalTransitionStyle = .crossDissolve
        present(modalViewController, animated: true, completion: nil)
    }
}

// TODO: MVVM에 맞게 로직 변경
extension VocaMainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VocaMainTableViewCell") as? VocaMainTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell()
        return cell
    }
}
