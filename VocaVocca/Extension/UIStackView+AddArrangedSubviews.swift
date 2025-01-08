//
//  UIStackView+AddArrangedSubviews.swift
//  GottaCatch'EmAll
//
//  Created by Eden on 1/5/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
