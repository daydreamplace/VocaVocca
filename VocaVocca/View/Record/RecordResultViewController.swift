//
//  RecordResultViewController.swift
//  VocaVocca
//
//  Created by 강민성 on 1/13/25.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RecordResultViewController: UIViewController {
    
    private let correctWordsView = RecordResultView()
    private let incorrectWordsView = RecordResultView()
    private let disposeBag = DisposeBag()
    private let viewModel: RecordResultViewModel
    
    init(viewModel: RecordResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindTableView()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        view.addSubview(correctWordsView)
        view.addSubview(incorrectWordsView)
        
        // 제약 조건 설정
        correctWordsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        incorrectWordsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 셀 등록
        correctWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
        incorrectWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
        
    }
    
    private func bindTableView() {
        // CorrectWordsView 바인딩
        viewModel.correctWords
            .bind(to: correctWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning) = wordPair
                cell.configureCell(isCorrect: true)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
            }
            .disposed(by: disposeBag)
        
        // IncorrectWordsView 바인딩
        viewModel.incorrectWords
            .bind(to: incorrectWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning) = wordPair
                cell.configureCell(isCorrect: false)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
            }
            .disposed(by: disposeBag)
    }
    
    func showCorrectWords() {
        correctWordsView.isHidden = false
        incorrectWordsView.isHidden = true
    }
    
    func showIncorrectWords() {
        correctWordsView.isHidden = true
        incorrectWordsView.isHidden = false
    }
}
