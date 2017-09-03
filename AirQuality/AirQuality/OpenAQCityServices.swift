//
//  OpenAQLocationServices.swift
//  AirQuality
//
//  Created by SERGIO J RAFAEL ORDINE on 22/08/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota
import UIKit

class OpenAQCityServices: CityServices {
    
    let citiesUrl:String
    let codeCountry:String
    
    var measureServices:MeasurementServices? 

    
    init(theCode code:String)
    {
        self.codeCountry = code
        self.citiesUrl = "https://api.openaq.org/v1/cities?country=\(self.codeCountry)&order_by=city"
    }
    
    
    func retrieveCity(completion:@escaping ([City]?) -> Void) {
        
        //Retrieve cities
        guard let url = URL(string: citiesUrl) else {
            completion(nil)
            return
        }
        
        //Montando a estrutura de URL e suas configurações
        let urlRequest = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            
            if (error == nil && data != nil) {
                do {
                    let citiesJSON = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let myCities = self.parseCities(citiesJSON) {
                        
                        //Create updated list
                        //var cityList = [City]()
                        
                        //Create group
                        //let citiesGroup = DispatchGroup()
                       // cityList.append(myCities)

                        completion(myCities)
                    }
                } catch {
                    completion(nil)
                }
            }
            
        }
        
        task.resume()
    }

    
    //MARK: - Location parsing methods
    
    //Função que parseia os dados de cada resultado
    func parseCities(_ json:Any) -> [City]? {
        
        var myCity = [City]()
        
        if let rootElement = json as? NSDictionary {
            if let results = rootElement["results"] as? NSArray {
                for cityData in results {
                    if let theCity = parseCity(cityData) {
                        myCity.append(theCity)
                    }
                }
            }
        }
        
        return myCity

    }
    
    
    //Função que parseia os dados de cada cidade
    func parseCity(_ json: Any) -> City? {
        
        if let cityData = json as? NSDictionary
        {
            if let name = cityData["city"] as? String, let qtdLocation = cityData["locations"] as? Int
            {
                let city = City(name: name, qtdeLocation: qtdLocation)
                return city
            }
        }
        
        return nil
        
    }
    

    
    
    

}
