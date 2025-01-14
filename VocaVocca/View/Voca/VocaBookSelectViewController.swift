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

final class VocaBookSelectViewController: UIViewController {
    
    private let vocaBookSelectView = VocaBookSelectView()
    private let disposeBag = DisposeBag()
    private let viewModel: VocaBookSelectViewModel
    
    override func loadView() {
        self.view = vocaBookSelectView
    }
    
    ///TODO - 데이터 넘겨받을 경우 생성자 수정
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
                        self?.testdeleteButtonTapped()
                    }).disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        // 셀 선택 시 바인딩
        vocaBookSelectView.collectionView.rx.modelSelected(VocaBookData.self)
            .subscribe(onNext: { [weak self] selectedBook in
                self?.selectedBook(book: selectedBook)
            })
            .disposed(by: disposeBag)
        
        // 셀 꾹 눌렀을 때 바인딩
        let longPressGesture = UILongPressGestureRecognizer()
        vocaBookSelectView.collectionView.addGestureRecognizer(longPressGesture)
        
        longPressGesture.rx.event
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
    
    ///TODO - 네비바 세팅 위치 보카메인뷰컨으로
    private func setUpNaviBar() {
        title = "단어장 선택"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = .customBlack
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료")
        navigationItem.rightBarButtonItem?.tintColor = .customBrown
    }
    
    ///TODO - 해당 단어장 삭제, 알럿
    // 셀 삭제 버튼 테스트
    private func testdeleteButtonTapped() {
        print("testButtonTapped")
    }
    
    // 단어장 추가버튼 로직
    private func createButtonTapped() {
        let vocaBookModalVM = VocaBookModalViewModel(mode: .create)
        let vocaBookModalVC = VocaBookModalViewController(viewModel: vocaBookModalVM)
        present(vocaBookModalVC, animated: true)
    }
    
    /// TODO - 네비바버튼 관련 로직 : 데이터 넘기기
    private func doneButtonTapped() {
        guard self.viewModel.selectedVocaBook != nil else { return }
        dismiss(animated: true)
    }
    
    /// TODO - 선택된 셀 로직
    private func selectedBook(book: VocaBookData) {
        viewModel.test(book)
//        viewModel.selectedVocaBook = book
//        print("\(book.title ?? "")")
    }
    
    /// TODO - 꾹 누른 셀 아이템 관련 로직
    private func handleLongPress(at indexPath: IndexPath) {
        guard let item = try? viewModel.vocaBookSubject.value()[indexPath.row] else { return }
        print("\(item.title ?? "")")
    }
    
}
