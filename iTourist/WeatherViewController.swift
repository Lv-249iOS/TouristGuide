//
//  WeatherViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import MapKit

class WeatherViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var change  = false
    var forecast: [Forecast]?
    
    @IBOutlet weak var myCollectionview: UICollectionView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var maxtemp1: UILabel!
    @IBOutlet weak var mintemp1: UILabel!
    @IBOutlet weak var feelslike: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    
    @IBAction func change(_ sender: UIButton) {
        displayCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let itemSize = UIScreen.main.bounds.height/4
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        layout.itemSize = CGSize(width: 1.2*itemSize, height: itemSize)
        //layout.minimumLineSpacing = 3
        //layout.minimumInteritemSpacing = 2
     //   myCollectionview.collectionViewLayout = layout
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(AppModel.shared.getCurrentLocation()) { [weak self] placemarks, err in
            if let city = placemarks?[0].addressDictionary?["City"] as? String {
                DispatchQueue.main.async {
                    self?.getWeatherforCity(city: city)
                }
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
    
    func displayCity() {
        let alert = UIAlertController(title: "Change city", message: "Please, enter city name", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel",style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK",style: UIAlertActionStyle.default) { (action) -> Void in
            if let name = alert.textFields?.first {
                self.getWeatherforCity(city: name.text!)
            }
        }
        
        alert.addAction(ok)
        alert.addTextField(configurationHandler: { (name) -> Void in
            name.placeholder = "City name"
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWeatherforCity(city: String) {
        if city != "" &&  city.characters.last != " "  {
            cityName.text = city
            let cityname  = city.replacingOccurrences(of: " ", with: "%20")
            guard let request = RequestFormatter().createWeatherRequest(with: cityname) else { return }
            
            Loader().load(with: request) { [weak self] data in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self?.forecast = WeatherParser().parse(with: data)
                    guard let todayForecast = self?.forecast?[0] else { return }
                    self?.setCurrentWeather(with: todayForecast)
                    self?.myCollectionview.reloadData()
                }
            }
        }
    }
    func setCurrentWeather(with forecast: Forecast) {
        currentTemp.text = "\(forecast.currentTemp)º"
        feelslike.text = "\(forecast.feelsTemp)º"
        today.text = forecast.date
        maxtemp1.text = "\(forecast.maxtemp)º"
        mintemp1.text = "\(forecast.mintemp)º"
        currentImg.image = forecast.image
    }
    
}



