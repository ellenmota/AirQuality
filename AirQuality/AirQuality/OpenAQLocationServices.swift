//
//  OpenAQLocationServices.swift
//  AirQuality
//
//  Created by Ellen Bianca Mota de Carvalho on 02/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import Foundation

class OpenAQLocationsServices:LocationServices
{
    var urlApi:String
    var cityName:String
    
    init(cityName city:String) {
        self.cityName = city
        self.urlApi = "https://api.openaq.org/v1/locations?city=\(self.cityName)"
    }
    
    
    func retrieveLocations(completion: @escaping ([Location]?) -> Void) {
        //Transformar a string recebida em formato de URL
        guard let url = URL(string: self.urlApi) else
        {
            completion(nil)
            return
        }
        
        //Configuraçoes de Url
        let urlRequest = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest)
        {
            [unowned self] (data, response, error) in
            
            //Trabalhando com Json
            if error==nil && data != nil
            {
                do
                {
                    let locationsJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let myLocations = self.parseLocations(locationsJSON)
                    {
                        completion(myLocations)
                    }
                
                } catch{
                    completion(nil)
                }

                
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    //Função para parsear Json
    func parseLocations(_ json:Any) ->[Location]?
    {
        var myLocation = [Location]()
        
        if let element = json as? NSDictionary
        {
            if let results = element["results"] as? NSArray
            {
                for locationData in results
                {
                    if let elementLocation = locationData as? NSDictionary
                    {
                        if let name = elementLocation["location"] as? String
                        {
                            let location = Location(name: name, measures: nil)
                            myLocation.append(location)
                        }
                    }
                }
            }
        }
        
        return myLocation
        
    }
    
   
    
}
