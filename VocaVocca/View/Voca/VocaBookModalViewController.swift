//
//  VocaBookModalViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class VocaBookModalViewController: UIViewController {
    
    // MARK: - Properties
    private let customModalView : CustomModalView
    
    // MARK: - Initializer
    init(title: String, buttonTitle: String) {
        self.customModalView = CustomModalView(title: title, buttonTitle: buttonTitle)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
