//
//  CoachmarkView.swift
//  VocaVocca
//
//  Created by mun on 1/10/25.
//

import UIKit
import SnapKit

class CoachmarkView: UIView {

    // MARK: - UI 컴포넌트

    // 닫기 버튼
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .none
        return button
    }()

    // 설명 이미지
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "hand.draw.fill")
        imageView.tintColor = .white
        return imageView
    }()

    // 설명 라벨
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = """
단어를 스와이프 하여 퀴즈를 풀어보세요!
아는 단어는 오른쪽, 모르는 단어는 왼쪽으로 밀어주세요
"""
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()

    // 체크박스 버튼
    let skipCheckboxButton: UIButton = {
        let button = UIButton() // selected 이미지 배경색 제거를 위해 기본으로 설정
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        button.tintColor = .white
        return button
    }()

    // 다시보지않음 라벨
    private let skipInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "다시 보지 않음"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        return label
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
        addSubviews(closeButton, imageView, instructionLabel, skipCheckboxButton, skipInstructionLabel)

        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(70)
        }

        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }

        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        skipCheckboxButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.trailing.equalTo(skipInstructionLabel.snp.leading).offset(-10)
            $0.height.equalTo(skipInstructionLabel)
        }

        skipInstructionLabel.snp.makeConstraints {
            $0.bottom.equalTo(skipCheckboxButton.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
