//
//  MeasureController.swift
//  AirQuality
//
//  Created by Ellen Bianca Mota de Carvalho on 02/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota

import UIKit

class MeasureController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var measure:[Measure] = [Measure]()
    var measureService: MeasurementServices?
    
    var dateToday = Date()
    var locationSelect:String = ""

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Transformação para a data necessária
        let thisDate = dateTranasform(dateToday: self.dateToday)
        
        measureService = OpenAQMeasureServices(dateToday: thisDate, location: (self.locationSelect))
        print(measureService ?? 0)
        
        measureService?.retrieveMeasures(completion: {
            [unowned self] (measure) in
            self.measure = measure!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    //Função que transforma a data atual para o formato necessário 
    //ex: 2017-09-03
    func dateTranasform(dateToday date:Date) -> String
    {
        let calendar = Calendar.current
        let year = calendar.component(.year , from: dateToday)
        let month = calendar.component(.month , from: dateToday)
        let day = calendar.component(.day , from:dateToday)
        
        let dateOficial = "\(year)-\(month)-\(day)"
        
        return dateOficial
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return measure.count 
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "measureCell", for: indexPath) as! measureCell
        cell.value.text = String(describing: measure[indexPath.row].value)
        cell.type.text = measure[indexPath.row].unit
        
        
        //Cores determinantes pela qualidade do ar
        let indicatorAir = airQualityOficial(valueMeasure: measure[indexPath.row].value)
        
        cell.viewIndicator.backgroundColor = indicatorAir.color
        cell.airIndicator.text = indicatorAir.indicator
        
        return cell
    }
    
    
    //Cores determinantes pela qualidade do ar
    func airQualityOficial(valueMeasure value:Double) -> AirIndicator
    {
        var thisIndicator:AirIndicator
        var color:UIColor
        var indicator:String
        
        if value <= 50
        {
            color = UIColor(red: 21/255, green: 211/255, blue: 0, alpha: 100)
            indicator = "Ar Bom 😊"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
            
        }
        else if value <= 100
        {
            color = UIColor(red: 247/255, green: 246/255, blue: 0, alpha: 100)
            indicator = "Ar Moderado 😐"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
        }
        else if value <= 150
        {
            color = UIColor(red: 255/255, green: 148/255, blue: 0, alpha: 100)
            indicator = "Ar Insalubre para grupos sensíveis 😞"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
        }
        else if value <= 200
        {
            color = UIColor(red: 255/255, green: 22/255, blue: 22/255, alpha: 100)
            indicator = "Ar Insalubre 😟"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
        }
        else if value <= 300
        {
            color = UIColor(red: 156/255, green: 0, blue: 177/255, alpha: 100)
            indicator = "Ar Muito Insalubre 😵"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
        }
        else
        {
            color = UIColor(red: 109/255, green: 53/255, blue: 2/255, alpha: 100)
            indicator = "Ar Perigoso 😱"
            thisIndicator = AirIndicator(color: color, indicator: indicator)
        }
        
        return thisIndicator
    }
    
    
}


