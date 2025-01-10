//
//  CoachmarkViewController.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class CoachmarkViewController: UIViewController {

    let coachmarkView = CoachmarkView()

    // MARK: - 생명주기 메서드

    override func loadView() {
        view = coachmarkView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6) // 투명도 설정
    }
}
