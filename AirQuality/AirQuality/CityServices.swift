//
//  LocationServices.swift
//  AirQuality
//
//  Created by SERGIO J RAFAEL ORDINE on 22/08/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import UIKit

protocol CityServices {
    
    
     /// Retrieve cities
     ///
     /// - Parameter completion: completion handler, that receives a list of locations in Campinas-SP
     func retrieveCity(completion:@escaping ([City]?) -> Void)

}
