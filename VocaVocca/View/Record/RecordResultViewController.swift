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
    
    // 테스트 더미 데이터
    private let dummyCorrectWords = [("apple", "사과"), ("banana", "바나나"), ("cherry", "체리"), ("date", "대추"), ("elderberry", "엘더베리")]
    private let dummyIncorrectWords = [("fig", "무화과"), ("grape", "포도"), ("honeydew", "허니듀"), ("kiwi", "키위"), ("lemon", "레몬")]
    
    // 데이터 소스
    private let correctWords = BehaviorRelay<[(String, String)]>(value: [])
    private let incorrectWords = BehaviorRelay<[(String, String)]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindTableView()
        loadDummyData() // 더미 데이터 로드
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
        // CorrectWordsView 테이블 뷰 바인딩
        correctWords
            .bind(to: correctWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning) = wordPair
                cell.configureCell(isCorrect: true)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
            }
            .disposed(by: disposeBag)
        
        // IncorrectWordsView 테이블 뷰 바인딩
        incorrectWords
            .bind(to: incorrectWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning) = wordPair
                cell.configureCell(isCorrect: false)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
            }
            .disposed(by: disposeBag)
    }
    
    private func loadDummyData() {
        // 더미 데이터 설정
        correctWords.accept(dummyCorrectWords)
        incorrectWords.accept(dummyIncorrectWords)
    }
    
    func showCorrectWords() {
        self.correctWordsView.isHidden = false
        self.incorrectWordsView.isHidden = true
    }
    
    func showIncorrectWords() {
        self.correctWordsView.isHidden = true
        self.incorrectWordsView.isHidden = false
    }
}
