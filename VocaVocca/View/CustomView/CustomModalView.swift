//
//  CustomModalView.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class CustomModalView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let contenStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        return button
    }()
}
