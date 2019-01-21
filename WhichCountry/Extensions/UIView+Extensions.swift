//
//  UIView+Extensions.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/18/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewsForAutolayout(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
