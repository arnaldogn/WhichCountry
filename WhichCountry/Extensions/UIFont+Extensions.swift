//
//  UIFont+Extensions.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

extension UIFont {
    static func custom(size: CGFloat = 12, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
