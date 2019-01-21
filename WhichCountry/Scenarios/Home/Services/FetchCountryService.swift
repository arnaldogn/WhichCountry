//
//  FetchCountryService.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/18/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import RxSwift
import RxCocoa
import MapKit

protocol FetchCountryServiceProtocol {
    func countries(by word: String) -> Observable<[Country]>
    var searchKind: SearchKind { get set } 
}

class FetchCountryService: FetchCountryServiceProtocol {
    var searchKind: SearchKind = .all
    
    private func searchURL(with kind: SearchKind, word: String) -> String {
        if kind == .code {
            return "\(Constants.baseURL)\(kind.description)?codes=\(word)"
        }
        let kind = word.isEmpty ? .all : kind
        var str = "\(Constants.baseURL)\(kind.description)/"
        if kind != .all {
            str.append(word)
        }
        return str
    }
    
    func countries(by word: String) -> Observable<[Country]> {
        let str = searchURL(with: searchKind, word: word)
        guard let url = URL(string: str) else {
            return Observable.just([])
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .retry(3)
            .map(parse)
            .catchErrorJustReturn([])
    }
    
    private func parse(json: Data) -> [Country] {
        let countries = try? JSONDecoder().decode([Country].self, from: json)
        return countries ?? [Country]()
    }
}

enum SearchKind: Int {
    case all
    case name
    case capital
    case language
    case code
    
    var description: String {
        switch self {
        case .code:
            return "alpha"
        case .name:
            return "name"
        case .capital:
            return "capital"
        case .language:
            return "language"
        default:
            return "all"
        }
    }
}

