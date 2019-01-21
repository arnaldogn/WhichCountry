//
//  DetailView.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit
import FlagKit

class DetailView: UIView {
    private let flagImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    func configure(with country: CountryDataModel) {
        flagImg.image = Flag(countryCode: country.code)?.originalImage
        stackView.addArrangedSubviews(UILabel(text: country.name, bold: true, alignment: .center),
                                      UILabel(text: country.capital + "\n", alignment: .center),
                                      UILabel(text: country.population),
                                      UILabel(text: country.region),
                                      UILabel(text: country.languages),
                                      UILabel(text: country.blocks),
                                      UILabel(text: country.currencies))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviewsForAutolayout(flagImg,
                                 stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        flagImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(snp.bottom)
            make.top.equalTo(flagImg.snp.bottom).offset(20)
        }
    }
}
