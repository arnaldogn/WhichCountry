//
//  UILabel+Extensions.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, bold: Bool = false, alignment: NSTextAlignment = .left) {
        self.init()
        font = UIFont.custom(weight: bold ? .bold : .regular)
        numberOfLines = 0
        textAlignment = alignment
        self.text = text
    }
}

