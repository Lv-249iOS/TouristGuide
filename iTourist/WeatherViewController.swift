//
//  WeatherViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var change  = false
    var forecast: [Forecast]?
    
    @IBAction func change(_ sender: UIButton) {
        displayCity()
    }
    
    @IBOutlet weak var myCollectionview: UICollectionView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var maxtemp1: UILabel!
    @IBOutlet weak var mintemp1: UILabel!
    @IBOutlet weak var feelslike: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=7&q=Lviv") else { return }
        
        Loader().load(with: URLRequest(url: url)) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.forecast = WeatherParser().parse(with: data)
                if let todayForecast = self.forecast?[0] {
                    self.currentTemp.text = "\(todayForecast.currentTemp)º"
                    self.feelslike.text = "\(todayForecast.feelsTemp)º"
                    self.today.text = todayForecast.date
                    self.maxtemp1.text = "\(todayForecast.maxtemp)º"
                    self.mintemp1.text = "\(todayForecast.mintemp)º"
                    self.currentImg.image = todayForecast.image
                }
                
                self.myCollectionview.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let forecast = forecast {
            return forecast.count - 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherCell, let weather = forecast {
            if indexPath.row < weather.count {
                cell.date.text = String(weather[indexPath.row + 1].date)
                cell.mintemp.text = String(weather[indexPath.row + 1].mintemp) + "º"
                cell.maxtemp.text = String(weather[indexPath.row + 1].maxtemp) + "º"
                cell.weatherImage.image = weather[indexPath.row + 1].image
            
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func displayCity() {
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel",style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK",style: UIAlertActionStyle.default){
            (action) -> Void in
            if let name = alert.textFields?.first {
                self.getWeatherforCity(city: name.text!)
            }
        }
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(name) -> Void in
            name.placeholder = "City name"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWeatherforCity(city: String) {
        cityName.text = city
        guard let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=7&q=" + city) else { return }
         
        Loader().load(with: URLRequest(url: url)) { data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.forecast = WeatherParser().parse(with: data)
                if let todayForecast = self.forecast?[0] {
                    self.currentTemp.text = "\(todayForecast.currentTemp)º"
                    self.feelslike.text = "\(todayForecast.feelsTemp)º"
                    self.today.text = todayForecast.date
                    self.maxtemp1.text = "\(todayForecast.maxtemp)º"
                    self.mintemp1.text = "\(todayForecast.mintemp)º"
                    self.currentImg.image = todayForecast.image
                }
                
                self.myCollectionview.reloadData()
            }
        }
    }
}
    


