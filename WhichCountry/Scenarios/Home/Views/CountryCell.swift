//
//  CountryCell.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/18/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit
import FlagKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    
    func configure(with country: CountryDataModel) {
        nameLbl.text = country.name
        populationLbl.text = country.population
        areaLbl.text = country.area
        flagImg.image = Flag(countryCode: country.code)?.originalImage
    }
    
    override func prepareForReuse() {
        flagImg.image = nil
    }
}
