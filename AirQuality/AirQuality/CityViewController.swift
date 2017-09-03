//
//  LocationViewController.swift
//  AirQuality
//
//  Created by SERGIO J RAFAEL ORDINE on 22/08/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import UIKit

class CityViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationTable: UITableView!
    
    var city:[City]? = [City]()
    
    var codeCountry:String = ""
    //MARK: - Services
    var cityServices: CityServices?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityServices = OpenAQCityServices(theCode: self.codeCountry)
        print(codeCountry)
        
        
        cityServices?.retrieveCity(completion: { [unowned self] (cities) in
            self.city = cities
            DispatchQueue.main.async { [unowned self] in
                self.locationTable.reloadData()
                
                //print(self.city ?? "")
            }
        })
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension CityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! cityCell
        let theCity = city?[indexPath.row]
        cell.cityName.text = theCity!.name
        cell.qtdLocation.text = String(describing: theCity!.qtdeLocation)
        
        
        return cell
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.city?.count ?? 0
    }

    //Passa dados para ViewController de cidades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "locationSegue"
        {
        
            if let index = tableView.indexPathForSelectedRow
            {
                let locationController = segue.destination as! LocationController
                locationController.cityName = (self.city?[index.row].name)!
            }
            
        }
    }
    
    
}
