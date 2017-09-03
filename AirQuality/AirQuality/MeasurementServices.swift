//
//  File.swift
//  AirQuality
//
//  Created by Sergio Ordine on 8/22/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import Foundation

protocol MeasurementServices {
    
   func retrieveMeasures(completion:@escaping ([Measure]?) -> Void)
    
}
