//
//  Country.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/18/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import Foundation
import MapKit

struct Country: Decodable {
    let name: String
    let population: Int
    let capital: String
    let region: String
    let area: Double?
    let alpha2Code: String
    let languages: [Language]
    let currencies: [Currency]?
    let blocks: [RegionalBlock]?
    var latlng: [Double]
    var location: CLLocation {
        get {
            guard latlng.count == 2 else { return CLLocation(latitude: 0, longitude: 0) }
            return CLLocation(latitude: latlng[0], longitude: latlng[1])
        }
    }
    enum CodingKeys: String, CodingKey {
        case name
        case population
        case capital
        case region
        case area
        case languages
        case alpha2Code
        case currencies
        case blocks = "regionalBlocs"
        case latlng
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}

struct Currency: Decodable {
    let name: String?
}


struct RegionalBlock: Decodable {
    let acronym: String?
}

struct Language: Decodable {
    let nativeName: String
}

struct CountryDataModel {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        return country.name
    }
    var population: String {
        return "Population: \(country.population)"
    }
    var capital: String {
        return country.capital
    }
    var region: String {
        return "Region: \(country.region)"
    }
    var area: String {
        guard let area = country.area else { return "" }
        return "Area: \(area)"
    }
    var code: String {
        return country.alpha2Code
    }
    var languages: String {
        guard country.languages.count > 0 else { return "" }
        return "Languages: " + country.languages.compactMap({
            return $0.nativeName
        }).joined(separator: ", ")
    }
    var blocks: String {
        guard let blocks = country.blocks, blocks.count > 0 else { return ""}
        return "Regional blocks: " + blocks.compactMap({
            return $0.acronym
        }).joined(separator: ", ")
    }
    var currencies: String {
        guard let currencies = country.currencies, currencies.count > 0 else { return ""}
        return "Currencies: " + currencies.compactMap({
            return $0.name
        }).joined(separator: ", ")
    }
}
