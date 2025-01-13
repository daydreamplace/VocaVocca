//
//  RecordResultViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
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
        view = correctWordsView // 맞은 단어 뷰를 표시
        correctWordsView.tableView.dataSource = self
        incorrectWordsView.tableView.dataSource = self
        correctWordsView.tableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: VocaMainTableViewCell.id)
        incorrectWordsView.tableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: VocaMainTableViewCell.id)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaMainTableViewCell.id, for: indexPath) as? VocaMainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell()
        
        return cell
    }
}
