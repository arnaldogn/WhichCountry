//
//  MainCoordinator.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDashboard()
    }
    
    func showDashboard() {
        let homeVC = ViewController.instantiate()
        homeVC.delegate = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension MainCoordinator: ViewControllerDelegate {
    func didSelect(country: CountryDataModel) {
        let detail = DetailViewController()
        detail.country = country
        navigationController.pushViewController(detail, animated: true)
    }
}
