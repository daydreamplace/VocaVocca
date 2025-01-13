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
        view = correctWordsView // 기본적으로 맞은 단어 뷰를 표시
        correctWordsView.tableView.dataSource = self
        incorrectWordsView.tableView.dataSource = self
        
        correctWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
        incorrectWordsView.tableView.register(RecordResultViewCell.self, forCellReuseIdentifier: RecordResultViewCell.id)
    }
    
    func showCorrectWords() {
        view = correctWordsView
    }
    
    func showIncorrectWords() {
        view = incorrectWordsView
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
        cell.cardView.meanLabel.text = "검정색"
        cell.cardView.wordLabel.text = "black"
        
        return cell
    }
}
