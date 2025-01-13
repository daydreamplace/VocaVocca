//
//  RecordResultViewController.swift
//  VocaVocca
//
//  Created by 강민성 on 1/13/25.
//


import UIKit
import SnapKit

final class RecordResultViewController: UIViewController {
    
    private let correctWordsView = RecordCorrectView()
    private let incorrectWordsView = RecordIncorrectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        
        // 데이터 소스 설정
        correctWordsView.tableView.dataSource = self
        incorrectWordsView.tableView.dataSource = self
        
        // 셀 등록
        correctWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
        incorrectWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
        
    }
    
    func showCorrectWords() {
        self.correctWordsView.isHidden = false
        self.incorrectWordsView.isHidden = true
        correctWordsView.tableView.reloadData()
    }
    
    func showIncorrectWords() {
        self.correctWordsView.isHidden = true
        self.incorrectWordsView.isHidden = false
        incorrectWordsView.tableView.reloadData()
    }
}

extension RecordResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordResultViewCell.id, for: indexPath) as? RecordResultViewCell else {
            return UITableViewCell()
        }
        
        let isCorrect = tableView == correctWordsView.tableView
        cell.configureCell(isCorrect: isCorrect)
        cell.cardView.meanLabel.text = isCorrect ? "검정색" : "파란색"
        cell.cardView.wordLabel.text = isCorrect ? "black" : "blue"
        
        return cell
    }
}
