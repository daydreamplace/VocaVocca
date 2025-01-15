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
    
    let correctWords: Observable<[(String, String, String)]>
    let incorrectWords: Observable<[(String, String, String)]>
    
    init(correctWords: Observable<[(String, String, String)]>, incorrectWords: Observable<[(String, String, String)]>) {
        self.correctWords = correctWords
        self.incorrectWords = incorrectWords
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면 전환을 자연스럽게 만들기 위한 CATransition 사용
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: false) // 기본 애니메이션 비활성화
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
        correctWords
            .bind(to: correctWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning, lanaguage) = wordPair
                cell.configureCell(isCorrect: true)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
                
                let setlanguage = Language(rawValue: lanaguage) ?? .english
                
                cell.languageTag.setTagView(color: setlanguage.color, label: lanaguage)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        // IncorrectWordsView 바인딩
        incorrectWords
            .bind(to: incorrectWordsView.tableView.rx.items(cellIdentifier: RecordResultViewCell.id, cellType: RecordResultViewCell.self)) { _, wordPair, cell in
                let (word, meaning, lanaguage) = wordPair
                cell.configureCell(isCorrect: false)
                cell.cardView.wordLabel.text = word
                cell.cardView.meanLabel.text = meaning
                
                let setlanguage = Language(rawValue: lanaguage) ?? .english
                cell.languageTag.setTagView(color: setlanguage.color, label: lanaguage)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    func showCorrectWords() {
        correctWordsView.isHidden = false
        incorrectWordsView.isHidden = true
        title = "암기한 단어"
    }
    
    func showIncorrectWords() {
        correctWordsView.isHidden = true
        incorrectWordsView.isHidden = false
        title = "틀린 단어"
    }
}
