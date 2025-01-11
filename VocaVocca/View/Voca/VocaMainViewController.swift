//
//  MainViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift

class VocaMainViewController: UIViewController {
    
    private let vocaMainView = VocaMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        view = vocaMainView
        vocaMainView.vocaTableView.register(VocaMainTableViewCell.self, forCellReuseIdentifier: "VocaMainTableViewCell")
        vocaMainView.vocaTableView.dataSource = self
        vocaMainView.vocaTableView.rowHeight = 160
        vocaMainView.vocaTableView.separatorStyle = .none
        
    }
    
}

//TODO: MVVM에 맞게 로직 변경
extension VocaMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VocaMainTableViewCell") as? VocaMainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell()
        return cell
    }
}


