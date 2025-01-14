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
        fetchVocaBookData()
        bindViewEvents()
        bindTableView()
        setUpNaviBar()
    }
    
    // MARK: - 네비게이션 바
    
    private func setUpNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = .customBlack
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
    }
    
    // MARK: - 선택된 단어장 조회
    
    private func fetchVocaBookData() {
        vocaMainViewModel.vocaBookSubject.subscribe(onNext: { vocaBookData in
            
            //TODO: 단어장 선택 시 값 받아오도록 할 예정
            //            self.vocaBookData = vocaBookData[0]
            //            let vocaBook = vocaBookData.last!
            //            print("vocaBookData :::::: \(vocaBook)")
            //            if let vocaBookTitle = vocaBookData.title {
            //                self.vocaMainView.vocaBookSelectButton.setTitle(vocaBookTitle, for: .normal)
            //            } else {
            //                self.vocaMainView.vocaBookSelectButton.setTitle("단어장을 생성해 주세요 >", for: .normal)
            //            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - 버튼 바인딩
    
    private func bindViewEvents() {
        vocaMainViewModel.selectedvocaBook
            .bind { [weak self] vocabook in
                self?.changeName(vocabook)
            }
            .disposed(by: disposeBag)
        
        let vocaBookSelectViewModel = VocaBookSelectViewModel(selectedVocaBook: vocaMainViewModel.selectedvocaBook)
        let vocaBookSelectViewController = VocaBookSelectViewController(viewModel: vocaBookSelectViewModel)
        vocaMainView.buttonTapRelay.subscribe(onNext: { action in
            switch action {
            case .vocaBookSelect:
                self.navigationController?.pushViewController(vocaBookSelectViewController, animated: true)
            case .makeVoca:
                self.present(self.vocaModalViewController, animated: true)
            }
        }).disposed(by: disposeBag)
        
        self.navigationController?.navigationItem.rightBarButtonItem?.rx
            .tap
            .bind { [weak self] _ in
                self?.closeView()
            }
    }
    
    // MARK: - 테이블뷰 바인딩
    
    private func bindTableView() {
        vocaMainViewModel.vocaBookSubject
            .observe(on: MainScheduler.instance)
            .bind(to: vocaMainView.vocaTableView.rx.items(
                cellIdentifier: VocaMainTableViewCell.id,
                cellType: VocaMainTableViewCell.self
            )) { row, element, cell in
                cell.cardView.meanLabel.text = element.meaning
                cell.cardView.wordLabel.text = element.word
            }.disposed(by: disposeBag)
    }
    
    
    private func changeName(_ vocaBook: VocaBookData) {
        vocaMainView.vocaBookSelectButton.setTitle(vocaBook.title, for: .normal)
    }
    
    private func closeView() {
        print("test")
        self.navigationController?.popViewController(animated: true)
    }
}
