//
//  CountryViewController.swift
//  AirQuality
//
//  Created by SERGIO J RAFAEL ORDINE on 22/08/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//Available in: https://github.com/ellenmota

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var countryTable: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    var countries:[Country]? = [Country]()
    
    
    
    //MARK: - Services
    var countryServices: CountryServices = OpenAQCountryServices()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        countryServices.retrieveCoutries(completion: { [unowned self] (countries) in
            self.countries = countries
            //TODO: Assynchronously update Country table view
            DispatchQueue.main.async { [unowned self] in
                self.countryTable.reloadData()
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension CountryViewController:UITableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryCell
        
        let country = countries?[indexPath.row]
        
        cell.countryName.text = country?.name
        cell.flagIcon.image = FlagMapper.flagIcon(code: country?.code)
        
        
        return cell
        
    }
    
    //Passa dados para ViewController de cidades
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "forCity"
        {
            if let index = tableView.indexPathForSelectedRow
            {
                let cityViewController = segue.destination as! CityViewController
                cityViewController.codeCountry = (countries?[index.row].code)!
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }

    
}
