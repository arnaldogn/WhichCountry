//
//  UIStackView+Extensions.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

