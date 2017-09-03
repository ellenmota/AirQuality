//
//  FakeMeasurementService.swift
//  AirQuality
//
//  Created by Sergio Ordine on 8/22/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import UIKit

class FakeMeasurementService: MeasurementServices {
    
    func retrieveMeasures(completion:@escaping ([Measure]?) -> Void) {
        
        let measurements = [Measure(date: Date(), type: .blackCarbon, value: 20.2, unit: "ppm"),
                            Measure(date: Date(), type: .carbonMonoxide, value: 8, unit: "ppm")]

        completion(measurements)
        
    }

}
