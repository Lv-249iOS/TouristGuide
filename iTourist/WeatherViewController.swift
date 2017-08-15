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
        //super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  UIDevice.current.orientation.isPortrait {
            let itemheight = UIScreen.main.bounds.height/4 - 3
            let itemwidth = UIScreen.main.bounds.width/2 - 2
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            layout.itemSize = CGSize(width: itemwidth, height: itemheight)
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 2
            myCollectionview.collectionViewLayout = layout
        }
        else if UIDevice.current.orientation.isLandscape {
            let itemheight = UIScreen.main.bounds.height/4 - 3
            let itemwidth = UIScreen.main.bounds.width/6 - 3
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            layout.itemSize = CGSize(width: itemwidth, height: itemheight)
            layout.minimumLineSpacing = 3
            layout.minimumInteritemSpacing = 2
            myCollectionview.collectionViewLayout = layout
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(AppModel.shared.getCurrentLocation()) { [weak self] placemarks, err in
            if let city = placemarks?[0].addressDictionary?["City"] as? String {
                
                DispatchQueue.main.async {
                    self?.getWeatherforCity(city: city)
                }
            }
        }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
            myCollectionview.collectionViewLayout.invalidateLayout()
            DispatchQueue.main.async {
            self.myCollectionview.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let forecast = forecast {
            return forecast.count - 1
        }
        
        return -1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherCell, let weather = forecast {
            if indexPath.row < weather.count {
                let height = UIScreen.main.bounds.height
                if height < 670 && UIDevice.current.orientation.isLandscape {
                    cell.date.font = cell.date.font.withSize(15)
                    cell.mintemp.font = cell.mintemp.font.withSize(15)
                    cell.maxtemp.font = cell.maxtemp.font.withSize(15)
                }
                
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
        cityName.text = city
        let cityname  = city.replacingOccurrences(of: " ", with: "%20")
        guard let request = RequestFormatter().createWeatherRequest(with: cityname) else { return }
        
        Loader().load(with: request) { [weak self] data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.forecast = WeatherParser().parse(with: data)
                if Constants.exists {
                    guard let todayForecast = self?.forecast?[0] else { return }
                    self?.setCurrentWeather(with: todayForecast)
                }
                self?.myCollectionview.reloadData()
            }
        }
        
        Constants.exists = true
    }
    
    
    func setCurrentWeather(with forecast: Forecast) {
        let height = UIScreen.main.bounds.height
        if height < 750{
            currentTemp.font = currentTemp.font.withSize(25)
            feelslike.font = feelslike.font.withSize(25)
            today.font = today.font.withSize(20)
            maxtemp1.font = maxtemp1.font.withSize(25)
            mintemp1.font = mintemp1.font.withSize(25)
            cityName.font = cityName.font.withSize(30)
        }
        currentTemp.text = "\(forecast.currentTemp)º"
        feelslike.text = "\(forecast.feelsTemp)º"
        today.text = forecast.date
        maxtemp1.text = "\(forecast.maxtemp)º"
        mintemp1.text = "\(forecast.mintemp)º"
        currentImg.image = forecast.image
    }
    
}



