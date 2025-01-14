//
//  MainViewController.swift
//  VocaVocca
//
//  Created by 안준경 on 1/8/25.
//

import CoreData
import UIKit
import RxSwift

final class VocaMainViewController: UIViewController {
    
    private let vocaMainView = VocaMainView()
    private let vocaMainViewModel = VocaMainViewModel()
    private let vocaBookSelectViewController = VocaBookSelectViewController()
    private var vocaBookData = VocaBookData()
    
    private let vocaModalViewController: VocaModalViewController = {
        let viewModel = VocaModalViewModel()
        let viewController = VocaModalViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .automatic
        viewController.view.backgroundColor = .none
        return viewController
    }()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        fetchVocaBookData()
        bindViewEvents()
    }
    
    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.dataSource = self
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
    }
    
//    private func fetchVocaBookData() {
//        vocaMainViewModel.vocaBookSubject.subscribe(onNext: { vocaBookData in
//
//            self.vocaBookData = vocaBookData
//
//            if let vocaBookTitle = vocaBookData.title {
//                self.vocaMainView.vocaBookSelectButton.setTitle(vocaBookTitle, for: .normal)
//            } else {
//                self.vocaMainView.vocaBookSelectButton.setTitle("단어장을 생성해 주세요 >", for: .normal)
//            }
//
//        }).disposed(by: disposeBag)
//    }
    
    private func bindViewEvents() {
        vocaMainView.buttonTapRelay.subscribe(onNext: { action in
            switch action {
            case .vocaBookSelect:
                self.navigationController?.pushViewController(self.vocaBookSelectViewController, animated: true)
            case .makeVoca:
                self.present(self.vocaModalViewController, animated: true)
            }
        }).disposed(by: disposeBag)
        
    }
}

extension VocaMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VocaMainTableViewCell") as? VocaMainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell()
        
        return cell
    }
}
