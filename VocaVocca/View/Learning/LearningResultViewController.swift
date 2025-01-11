//
//  LearningResultViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

final class LearningResultViewController: UIViewController {
    
    private let learningResultView = LearningResultView()
    
    override func loadView() {
        self.view = learningResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    ///TODO - 뷰에 있는 버튼 로직 처리
    private func setupButton() {
        learningResultView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        print(#function)
        dismiss(animated: true, completion: nil)
    }
}
