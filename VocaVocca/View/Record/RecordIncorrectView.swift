//
//  RecordIncorrectView.swift
//  VocaVocca
//
//  Created by 강민성 on 1/13/25.
//

import UIKit
import SnapKit

class RecordIncorrectView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: VocaMainTableViewCell.id)
        tableView.rowHeight = 160 // 셀 높이 동일하게 설정
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
