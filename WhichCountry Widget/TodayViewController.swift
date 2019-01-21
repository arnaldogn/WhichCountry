//
//  TodayViewController.swift
//  WhichCountry Widget
//
//  Created by Arnaldo on 1/21/19.
//  Copyright © 2019 Arnaldo. All rights reserved.
//

import UIKit
import NotificationCenter
import FlagKit

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var capitalLbl: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = FetchCountryService()
        service.searchKind = .code
        let locale = Locale.current
        guard let code = locale.regionCode else { return }
        _ = service.countries(by: code).asObservable().subscribe(onNext: { (response) in
            DispatchQueue.main.async {
                self.nameLbl.text = response.first?.name
                self.capitalLbl.text = response.first?.capital
                if let code = response.first?.alpha2Code {
                    self.flagImg.image = Flag(countryCode: code)?.originalImage
                }
            }
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        completionHandler(NCUpdateResult.newData)
    }
}
