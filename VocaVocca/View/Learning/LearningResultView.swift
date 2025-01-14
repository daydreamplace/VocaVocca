//
//  LearningResultView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class LearningResultView: UIView {
    
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "학습 결과"
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .customBlack
        return label
    }()
    
    ///TODO - 숫자 관련 색상, 로직 필요
    let correctCountLabel: UILabel = {
        let label = UILabel()
        label.text = "정답 16"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.text = "오답 3"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let correctRateLabel: UILabel = {
        let label = UILabel()
        label.text = "정답률 90%"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let couponContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.customBlack.cgColor
        return view
    }()
    
    private let couponLabel: UILabel = {
        let label = UILabel()
        label.text = "볶아 쿠폰"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var coffeeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // 커피콩 이미지 담을 배열
    private var coffeeBeans: [UIImageView] = []
    
    private let resultDiscriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "당신의 학습결과를 확인해보세요!"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .customBlack
        return label
    }()
    
    lazy var closeButton: CustomButton = {
        let button = CustomButton(title: "종료하기")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCoffeeBeans()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear.withAlphaComponent(0.8)
        addSubview(backGroundView)
        
        backGroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(500)
            $0.width.equalTo(300)
        }
        
        countStackView.addArrangedSubviews(correctCountLabel, incorrectCountLabel)
        backGroundView.addSubviews(resultLabel, countStackView, correctRateLabel, couponContentView, closeButton)
        couponContentView.addSubviews(couponLabel, coffeeStackView, resultDiscriptionLabel)
        
        resultLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        correctRateLabel.snp.makeConstraints {
            $0.top.equalTo(countStackView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        couponContentView.snp.makeConstraints {
            $0.top.equalTo(correctRateLabel.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().inset(100)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
        
        couponLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        coffeeStackView.snp.makeConstraints {
            $0.top.equalTo(couponLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        resultDiscriptionLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupCoffeeBeans() {
        
        // 가로 두줄
        for _ in 0..<2 {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 8
            horizontalStackView.distribution = .fillEqually
            
            ///TODO - 
            // 한줄에 5개 이미지
            for _ in 0..<5 {
                let imageView = UIImageView(image: UIImage(systemName: "circle.fill"))
                imageView.tintColor = .customDarkerBrown
                imageView.alpha = 0.2
                coffeeBeans.append(imageView)
                horizontalStackView.addArrangedSubview(imageView)
            }
            coffeeStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    // 커피콩 갯수 업데이트
    func updateCoffeeBeans(correctCount: Int) {
        for (index, imageView) in coffeeBeans.enumerated() {
            imageView.alpha = index < correctCount ? 1.0 : 0.2
        }
    }
}
