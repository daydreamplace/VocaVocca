//
//  CustomButton.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class CustomButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init(title: String, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        commonInit()
        setTitle(title, for: .normal)
    }
    
    private func commonInit() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .customDarkerBrown
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if frame.height > 0 {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

