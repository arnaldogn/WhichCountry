//
//  Storyboard.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case Main
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
