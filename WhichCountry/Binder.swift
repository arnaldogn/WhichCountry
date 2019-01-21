//
//  Binder.swift
//  WhichCountry
//
//  Created by Arnaldo on 1/19/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import Swinject

public class Binder {
    
    private lazy var container = Container()
    public static let shared = Binder()
    
    init() {
        setup()
    }
    
    func setup() {
        setupServices()
        setupViewModels()
    }
}

extension Binder {
    private func setupServices() {
        bind(FetchCountryServiceProtocol.self, to: FetchCountryService())
    }
    
    private func setupViewModels() {
        container.register(ViewModelProtocol.self) {
            return ViewModel(service: $0.resolve(FetchCountryServiceProtocol.self)!)
        }
    }
}

public extension Binder {
    public func bind<T>(_ interface: T.Type, to assembly: T, scope: ObjectScope = .graph) {
        container.register(interface) { _ in assembly }.inObjectScope(scope)
    }
    public func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }
    static func bind<T>(interface: T.Type, to assembly: T) {
        Binder.shared.bind(interface, to: assembly)
    }
    static func resolve<T>(_ interface: T.Type) -> T! {
        return Binder.shared.resolve(interface: interface)
    }
}
