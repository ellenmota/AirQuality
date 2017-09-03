//
//  LocationControllerViewController.swift
//  AirQuality
//
//  Created by Ellen Bianca Mota de Carvalho on 02/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import UIKit

class LocationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var location:[Location]? = [Location]()
    var locationService:LocationServices?
    var cityName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService = OpenAQLocationsServices(cityName: self.cityName)
        locationService?.retrieveLocations(completion: {
            [unowned self] (location) in
            
            self.location = location
            
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! locationCell
        cell.locationName.text = location?[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.location?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measureSegue"
        {
            if let index = tableView.indexPathForSelectedRow
            {
                let controllerMeasure = segue.destination as! MeasureController
                controllerMeasure.locationSelect = (location?[index.row].name)!
            }
           
        }
    }

}



