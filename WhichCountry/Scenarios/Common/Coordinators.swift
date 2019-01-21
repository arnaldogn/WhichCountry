//
//  Coordinator.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
