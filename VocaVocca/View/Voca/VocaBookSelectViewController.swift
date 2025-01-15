//
//  VocaBookSelectViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class VocaBookSelectViewController: UIViewController {
    
    private let vocaBookSelectView = VocaBookSelectView()
    private let disposeBag = DisposeBag()
    private let viewModel: VocaBookSelectViewModel
    
    override func loadView() {
        self.view = vocaBookSelectView
    }
    
    init(viewModel: VocaBookSelectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchVocaBookFromCoreData()
    }
    
    // 테이블 뷰에 데이터 바인딩
    private func bind() {
        viewModel.vocaBookSubject
            .observe(on: MainScheduler.instance)
            .bind(to: vocaBookSelectView.collectionView.rx.items(cellIdentifier: VocaBookSelectCell.id, cellType: VocaBookSelectCell.self)) {
                index, item, cell in
                
                cell.vocaBookNameLabel.text = item.title
                cell.wordsCountLabel.text = ("단어 \(item.words?.count ?? 0)개")
                
                // 셀 버튼액션 바인딩
                cell.deleteButton.rx.tap
                    .subscribe(onNext: { [weak self] in
                        self?.showDeleteAlert(for: item)
                    }).disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        // 셀 선택 시 바인딩
        vocaBookSelectView.collectionView.rx.modelSelected(VocaBookData.self)
            .subscribe(onNext: { [weak self] selectedBook in
                self?.selectedBook(book: selectedBook)
            })
            .disposed(by: disposeBag)
        
        // 셀 꾹 눌렀을 때 바인딩
        vocaBookSelectView.collectionView.rx.longPressGesture()
            .when(.began)
            .filter { $0.state == .began }
            .compactMap { [weak self] gesture -> IndexPath? in
                guard let collectionView = self?.vocaBookSelectView.collectionView else { return nil }
                let location = gesture.location(in: collectionView)
                return collectionView.indexPathForItem(at: location)
            }
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.handleLongPress(at: indexPath)
            })
            .disposed(by: disposeBag)
        
        // 단어장 추가 버튼 바인딩
        vocaBookSelectView.createButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.createButtonTapped()
            }).disposed(by: disposeBag)
        
        // 네비바 버튼 바인딩
        self.navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.doneButtonTapped()
            }).disposed(by: disposeBag)
    }
    
    private func setUpNaviBar() {
        title = "단어장 선택"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료")
        navigationItem.rightBarButtonItem?.tintColor = .customBrown
    }
    
    // 단어장 추가버튼 로직
    private func createButtonTapped() {
        let vocaBookModalVM = VocaBookModalViewModel(mode: .create)
        let vocaBookModalVC = VocaBookModalViewController(viewModel: vocaBookModalVM)
        
        vocaBookModalVM.saveCompleted
            .subscribe(onNext: { [weak self] in
                self?.viewModel.fetchVocaBookFromCoreData()
            })
            .disposed(by: disposeBag)
        
        present(vocaBookModalVC, animated: true)
    }
    
    private func doneButtonTapped() {
        self.viewModel.closeSubject.onNext(())
        guard self.viewModel.selectedVocaBook != nil else { return }
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func selectedBook(book: VocaBookData) {
        viewModel.test(book)
        viewModel.selectedVocaBook.onNext(book)
    }
    
    private func handleLongPress(at indexPath: IndexPath) {
        guard let item = try? viewModel.vocaBookSubject.value()[indexPath.row] else { return }
    }
    
    // 삭제 알럿
    private func showDeleteAlert(for vocaBook: VocaBookData) {
        let alert = UIAlertController(
            title: "삭제 확인",
            message: "정말로 단어장을 삭제하시겠습니까?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteVocaBook(vocaBook)
        }))
        present(alert, animated: true)
    }
    
    private func showDeletionSuccessAlert() {
        let alert = UIAlertController(
            title: "삭제 완료",
            message: "단어장이 삭제되었습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
}
