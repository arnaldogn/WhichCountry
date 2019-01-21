

import RxSwift
import RxCocoa
import MapKit

protocol ViewModelProtocol {
    var searchKind: SearchKind? { get set }
    var data: Driver<[Country]> { get }
    var searchText: Variable<String> { get }
}

class ViewModel: ViewModelProtocol {
    private var service: FetchCountryServiceProtocol
    var searchText = Variable("")
    var searchKind: SearchKind? {
        didSet {
            guard let kind = searchKind  else { return }
            service.searchKind = kind
        }
    }
    lazy var data: Driver<[Country]> = {
        return self.searchText.asObservable()
            .throttle(2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(service.countries)
            .asDriver(onErrorDriveWith: Driver.empty())
    }()
    
    init(service: FetchCountryServiceProtocol) {
        self.service = service        
    }
}

