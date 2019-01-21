//
//  ViewController.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/17/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

protocol ViewControllerDelegate: class {
    func didSelect(country: CountryDataModel)
}

class ViewController: UIViewController, Storyboarded {
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { return searchController.searchBar }
    private var viewModel = Binder.resolve(ViewModelProtocol.self)
    private let disposeBag = DisposeBag()
    weak var delegate: ViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    private let dataSource = Variable<[Country]>([])
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupViews()
        configureSearchController()
    }
    
    private func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupViews() {
        tableView.rowHeight = 110
        searchBar.delegate = self
        guard let viewModel = viewModel else { return }
    
        dataSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, country, cell in
            guard let cell = cell as? CountryCell else { return }
            cell.configure(with: CountryDataModel(country: country))
            }
            .disposed(by: disposeBag)
        
        viewModel.data
            .drive(dataSource)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.data.asDriver()
            .map { "\($0.count) Countries" }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Country.self).subscribe { [weak self] country in
            guard let selectedItem = country.element else { return }
            print(selectedItem.location)
            self?.delegate?.didSelect(country: CountryDataModel(country: selectedItem))
        }
        .disposed(by: disposeBag)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.scopeButtonTitles = ["All", "Name", "Capital", "Language"]
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let kind = SearchKind(rawValue: selectedScope) else { return }
        viewModel?.searchKind = kind
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let myLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        if !(myLocation.coordinate.latitude == 0 && myLocation.coordinate.longitude == 0) {
            var sorted = dataSource.value
            sorted.sort (by: { $0.distance(to: myLocation) < $1.distance(to: myLocation) })
            dataSource.value = sorted
            tableView.reloadData()
        }
    }
}
