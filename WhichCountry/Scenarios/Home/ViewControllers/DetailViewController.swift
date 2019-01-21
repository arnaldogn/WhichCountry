//
//  DetailViewController.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/18/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    var country: CountryDataModel? {
        didSet {
            guard let country = country else { return }
            detailView.configure(with: country)
        }
    }
    private let detailView = DetailView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviewsForAutolayout(detailView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        detailView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
