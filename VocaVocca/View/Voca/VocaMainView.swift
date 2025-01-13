//
//  VocaMainView.swift
//  VocaVocca
//
//  Created by t2023-m0072 on 1/9/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class VocaMainView: UIView {
    
    let buttonTapRelay = PublishRelay<Void>()
    let disposeBag = DisposeBag()
            
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "보카볶아"
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = UIColor.customDarkBrown
        return label
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoImage")
        return image
    }()
    
    let vocaBookSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("단어장을 선택해 주세요 >", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        button.setTitleColor(UIColor.customDarkBrown, for: .normal)
        button.backgroundColor = .none
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let vocaTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.borderColor = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        buttonBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(titleLable, logoImageView, vocaBookSelectButton, vocaTableView)
        
        titleLable.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(30)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(titleLable)
            $0.leading.equalTo(titleLable.snp.trailing).offset(5)
            $0.width.height.equalTo(30)
        }
        
        vocaBookSelectButton.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        vocaTableView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectButton.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func buttonBind() {
        vocaBookSelectButton.rx.tap
            .bind(to: buttonTapRelay).disposed(by: disposeBag)
    }
}



