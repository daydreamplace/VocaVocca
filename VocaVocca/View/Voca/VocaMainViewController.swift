//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift

final class VocaMainViewController: UIViewController {
    
    private let vocaMainView = VocaMainView()
    private let vocaBookSelectVC = VocaBookSelectViewController()
    
    private let vocaModalVC: VocaModalViewController = {
        let viewController = VocaModalViewController()
        viewController.modalPresentationStyle = .automatic
        viewController.view.backgroundColor = .none
        return viewController
    }()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewEvents()
    }
    
    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.dataSource = self
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
        
    }
    
    private func bindViewEvents() {
        vocaMainView.buttonTapRelay.subscribe(onNext: { action in
            switch action {
            case .vocaBookSelect:
                self.navigationController?.pushViewController(self.vocaBookSelectVC, animated: true)
            case .makeVoca:
                self.present(self.vocaModalVC, animated: true)
            }
        }).disposed(by: disposeBag)
        
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


