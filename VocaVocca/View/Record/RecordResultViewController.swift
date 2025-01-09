//
//  RecordResultViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class RecordResultViewController: UIViewController {
    
    private let correctView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let correctLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "오늘 암기한 단어"
        return label
    }()
    
    private let correctCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textAlignment = .center
        label.text = "15"
        label.textColor = .systemBlue
        return label
    }()
    
    private let incorrectView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let incorrectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.text = "오늘 틀린 단어"
        return label
    }()
    
    private let incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textAlignment = .center
        label.text = "15"
        label.textColor = .systemRed
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        correctView.addSubviews(correctLabel, correctCountLabel)
        incorrectView.addSubviews(incorrectLabel, incorrectCountLabel)
        view.addSubviews(correctView, incorrectView)
        
        correctView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.height.equalTo(160)
        }
        
        correctLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        correctCountLabel.snp.makeConstraints { make in
            make.top.equalTo(correctLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        incorrectView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(correctView.snp.bottom).offset(60)
            make.height.equalTo(160)
        }
        
        incorrectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }
        
        incorrectCountLabel.snp.makeConstraints { make in
            make.top.equalTo(incorrectLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
