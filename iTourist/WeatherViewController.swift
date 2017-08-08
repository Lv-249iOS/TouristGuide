//
//  WeatherViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBAction func cityChange(_ sender: UIBarButtonItem) {
        displayCity()
    }
    
    
    @IBOutlet weak var maxtemp1: UILabel!

    @IBOutlet weak var maxtemp2: UILabel!
    
    @IBOutlet weak var maxtemp3: UILabel!
    
    @IBOutlet weak var mintemp1: UILabel!
    
 
    @IBOutlet weak var mintemp2: UILabel!
    
    
   
    @IBOutlet weak var mintemp3: UILabel!
    
   
    @IBOutlet weak var cityName: UILabel!
    

    @IBOutlet weak var feelslike: UILabel!
    

    @IBOutlet weak var currentTemp: UILabel!
   
    
    @IBOutlet weak var today: UILabel!
    
    @IBOutlet weak var tomorrow: UILabel!
    
    @IBOutlet weak var aftertomorrow: UILabel!
    

    
    var change  = false
    var forecast: [Forecast] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let parse = WeatherParser()
        
        guard let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=3&q=Lviv") else { return }
        parse.parse(with: url) { forecast, err in
            if let forecast1 = forecast as? [Forecast] {
                DispatchQueue.main.async {
                    
                    self.forecast = forecast1
                    self.currentTemp.text = "\(forecast1[0].currentTemp)º"
                    self.feelslike.text = "\(forecast1[0].feelsTemp)º"
                    self.today.text = forecast1[0].date
                    self.maxtemp1.text = "\(forecast1[0].maxtemp)º"
                    self.mintemp1.text = "\(forecast1[0].mintemp)º"
                    
                    self.tomorrow.text = forecast1[1].date
                    self.maxtemp2.text = "\(forecast1[1].maxtemp)º"
                    self.mintemp2.text = "\(forecast1[1].mintemp)º"
                    
                    self.aftertomorrow.text = forecast1[2].date
                    self.maxtemp3.text = "\(forecast1[2].maxtemp)º"
                    self.mintemp3.text = "\(forecast1[2].mintemp)º"
                    
                }
            }
        }
    }
    
    func displayCity() {
        let alert = UIAlertController(title: "City", message: "Enter city name",preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel",style: UIAlertActionStyle.cancel, handler :nil)
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK",style: UIAlertActionStyle.default){
            (action) -> Void in
            if let name = alert.textFields?.first  {
                self.getWeatherforCity(city: name.text!)
            }
        }
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(name) -> Void in
            name.placeholder = "City name"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWeatherforCity(city: String){
        cityName.text = city
        let parse = WeatherParser()
        guard let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=3&q="+city) else { return }
        parse.parse(with: url) { forecast, err in
            if let forecast1 = forecast as? [Forecast] {
                DispatchQueue.main.async {
                    self.forecast = forecast1
                    self.currentTemp.text = "\(forecast1[0].currentTemp)º"
                    self.feelslike.text = "\(forecast1[0].feelsTemp)º"
                    self.today.text = forecast1[0].date
                    self.maxtemp1.text = "\(forecast1[0].maxtemp)º"
                    self.mintemp1.text = "\(forecast1[0].mintemp)º"
                    
                    self.tomorrow.text = forecast1[1].date
                    self.maxtemp2.text = "\(forecast1[1].maxtemp)º"
                    self.mintemp2.text = "\(forecast1[1].mintemp)º"
                    
                    self.aftertomorrow.text = forecast1[2].date
                    self.maxtemp3.text = "\(forecast1[2].maxtemp)º"
                    self.mintemp3.text = "\(forecast1[2].mintemp)º"
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
