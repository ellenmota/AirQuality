//
//  LocationServices.swift
//  AirQuality
//
//  Created by Ellen Bianca Mota de Carvalho on 02/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import Foundation

protocol LocationServices {
    
    func retrieveLocations(completion: @escaping([Location]?) -> Void)
    
}
