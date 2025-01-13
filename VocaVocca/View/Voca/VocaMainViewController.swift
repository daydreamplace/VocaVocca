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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindActions()
    }
    
    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.dataSource = self
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
    }
    
    private func bindActions() {
        vocaMainView.openModalButton.rx.tap
            .bind { [weak self] in
                self?.openVocaModal()
            }
            .disposed(by: disposeBag)
    }
    
    private func openVocaModal() {
        let vocaModalViewModel = VocaModalViewModel()
        let vocaModalVC = VocaModalViewController(viewModel: vocaModalViewModel)
        vocaModalVC.modalPresentationStyle = .overFullScreen
        self.present(vocaModalVC, animated: true, completion: nil)
    }
}

//TODO: MVVM에 맞게 로직 변경
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

