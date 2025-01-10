//
//  FlashcardViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import SnapKit

class FlashcardViewController: UIViewController {

    // MARK: - UI 컴포넌트
    
    let flashcardView = FlashcardView()

    // MARK: - 생명주기 메서드

    override func loadView() {
        view = flashcardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
}
