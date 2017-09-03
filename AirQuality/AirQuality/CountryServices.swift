//
//  CountryServices.swift
//  AirQuality
//
//  Created by SERGIO J RAFAEL ORDINE on 22/08/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import Foundation


protocol CountryServices {
    
    
    /// List of countries registered
    ///
    /// - Parameter completion: Completion handler that receives a list of countries as parameter
    func retrieveCoutries(completion:@escaping ([Country]?) -> Void)
    
}
