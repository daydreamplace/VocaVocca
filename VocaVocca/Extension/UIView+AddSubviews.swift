//
//  UIView+AddSubviews.swift
//  BookKeeper
//
//  Created by Eden on 12/31/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
