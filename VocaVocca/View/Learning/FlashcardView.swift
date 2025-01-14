//
//  FlashcardView.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

import UIKit
import SnapKit

class FlashcardView: UIView {

    // MARK: - UI 컴포넌트

    // 닫기 버튼
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.tintColor = .customBlack
        return button
    }()

    // 진행된 숫자 표시 라벨
    private let countView = {
        let view = UIView()
        return view
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .customBlack
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let connectLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = .customBlack
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let totalCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .customBlack
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    // 플래시카드 뷰
    let flashcardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()

    // 단어 라벨
    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    // 버튼 스택뷰
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    // 몰라요 버튼
    let notYetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("잘 모르겠어요", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()

    // 알아요 버튼
    let gotItButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("알아요", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        backgroundColor = .systemGray5

        addSubviews(closeButton, countView, flashcardView, buttonStackView)
        countView.addSubviews(countLabel, connectLabel, totalCountLabel)
        flashcardView.addSubview(wordLabel)
        buttonStackView.addArrangedSubviews(notYetButton, gotItButton)

        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(20)
        }

        countView.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(connectLabel.snp.leading).offset(-10)
        }
        
        connectLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        totalCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(connectLabel.snp.trailing).offset(10)
        }
        
        flashcardView.snp.makeConstraints {
            $0.top.equalTo(countView.snp.bottom).offset(30)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-30)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }

        wordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }

        notYetButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        gotItButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
