//
//  WeatherViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import MapKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var myCollectionview: UICollectionView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var maxtemp1: UILabel!
    @IBOutlet weak var mintemp1: UILabel!
    @IBOutlet weak var feelslike: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    @IBOutlet weak var degrees: UILabel!
    
    var change  = false
    var forecast: [Forecast]?
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    var startLandscape = false
    var isIpad = false
    let value =  UserDefaults.standard.value(forKey: PathForSettingsKey.celcius.rawValue) as? Bool
    
    @IBAction func changecityname(_ sender: UIButton) {
        displayCity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func layout(width: CGFloat, heigth: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSize(width: width, height: heigth)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        myCollectionview.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isIpad = traitCollection.userInterfaceIdiom == .pad ? true : false
        setSizeOfCollectionViewCell()
        setWeather(for: AppModel.shared.getLocation())
    }
    
    func setWeather(for location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, err in
            if let city = placemarks?[0].addressDictionary?["City"] as? String {
                DispatchQueue.main.async {
                    self?.getWeather(for: city)
                }
            }
        }
    }
    
    func setSizeOfCollectionViewCell() {
        if UIDevice.current.orientation.isPortrait {
            if !isIpad {
                layout(width: UIScreen.main.bounds.width / 2 - 2, heigth: UIScreen.main.bounds.height / 4 - 2)
            } else {
                layout(width: UIScreen.main.bounds.width / 3 - 2, heigth: UIScreen.main.bounds.height / 4 - 2)
            }
        }
        
        if UIDevice.current.orientation.isLandscape {
            startLandscape = true
            layout(width: UIScreen.main.bounds.width / 6 - 2, heigth: UIScreen.main.bounds.height / 4 - 2)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            if let layout = self.myCollectionview?.collectionViewLayout as? UICollectionViewFlowLayout {
                myCollectionview?.collectionViewLayout.invalidateLayout()
                if startLandscape{
                    layout.itemSize = CGSize(width: width / 6 - 2, height: height / 4 - 2)
                } else {
                    layout.itemSize = CGSize(width: height / 6 - 2, height: width / 4 - 2)
                }
            }
        } else if UIDevice.current.orientation.isPortrait {
            if let layout = self.myCollectionview?.collectionViewLayout as? UICollectionViewFlowLayout {
                myCollectionview?.collectionViewLayout.invalidateLayout()
                
                if startLandscape && !isIpad {
                    layout.itemSize = CGSize(width: height / 2 - 2, height: width / 4 - 2)
                } else if isIpad && !startLandscape {
                    layout.itemSize = CGSize(width: width / 3 - 2, height: height / 4 - 2)
                } else if isIpad && startLandscape {
                    layout.itemSize = CGSize(width: height / 3 - 2, height: width / 4 - 2)
                } else {
                    layout.itemSize = CGSize(width: width / 2 - 2, height: height / 4 - 2)
                }
            }
        }
        
        myCollectionview.reloadData()
    }
    
    func displayCity() {
        let alert = UIAlertController(title: "Change city", message: "Please, enter city name", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel",style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        let ok = UIAlertAction(title: "OK",style: UIAlertActionStyle.default) { (action) -> Void in
            if let name = alert.textFields?.first {
                self.getWeather(for: name.text!)
            }
        }
        
        alert.addAction(ok)
        alert.addTextField(configurationHandler: { (name) -> Void in
            name.placeholder = "City name"
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getWeather(for city: String) {
        cityName.text = city
        let cityname  = city.replacingOccurrences(of: " ", with: "%20")
        guard let request = RequestFormatter().createWeatherRequest(with: cityname) else { return }
        
        Loader().load(with: request) { [weak self] data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.forecast = WeatherParser().parse(with: data)
                
                if AppModel.shared.constants.cityForWeatherParseExists {
                    guard let todayForecast = self?.forecast?[0] else { return }
                    self?.setCurrentWeather(with: todayForecast)
                } else {
                    self?.currentTemp.text = ""
                    self?.feelslike.text = ""
                    self?.today.text = ""
                    self?.maxtemp1.text = ""
                    self?.mintemp1.text = ""
                    self?.currentImg.image = UIImage(named:"noImage.png")
                    self?.cityName.text = "CITY NOT FOUND"
                }
                
                self?.myCollectionview.reloadData()
            }
        }
        
        AppModel.shared.constants.cityForWeatherParseExists = true
    }
    
    func setCurrentWeather(with forecast: Forecast) {
        if height < 750  {
            currentTemp.font = currentTemp.font.withSize(25)
            feelslike.font = feelslike.font.withSize(25)
            today.font = today.font.withSize(23)
            maxtemp1.font = maxtemp1.font.withSize(25)
            mintemp1.font = mintemp1.font.withSize(25)
            cityName.font = cityName.font.withSize(30)
        }
        
        today.text = forecast.date
        
        if value == true {
            let myString:NSString = "Degrees: Cº"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String,
                                                        attributes: [NSFontAttributeName:UIFont(name: "Verdana", size: 23.0) ?? UIFont() ])
            myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location:0,length:8))
            myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSRange(location:9,length:2))
            degrees.attributedText = myMutableString
            //degrees.attributedText = myMutableString
            
            currentTemp.text = "\(forecast.currentTemp ?? 0)º"
            feelslike.text = "\(forecast.feelsTemp ?? 0)º"
            maxtemp1.text = "\(forecast.maxtemp)º"
            mintemp1.text = "\(forecast.mintemp)º"
        }
        else {
            let myString:NSString = "Degrees: Fº"
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: myString as String,attributes: [NSFontAttributeName:UIFont(name: "Verdana", size: 23.0) ?? UIFont() ])
            myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location:0,length:8))
            myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange, range: NSRange(location:9,length:2))
            degrees.attributedText = myMutableString
            
            
            currentTemp.text = "\(convertdegrees(with:forecast.currentTemp ?? 0))º"
            feelslike.text = "\(convertdegrees(with:forecast.feelsTemp ?? 0))º"
            maxtemp1.text = "\(convertdegrees(with:forecast.maxtemp))º"
            mintemp1.text = "\(convertdegrees(with:forecast.mintemp))º"
        }
        currentImg.image = forecast.image
    }
    
    func convertdegrees (with celcius: Int)-> Int{
        var farenheit = Double(celcius)
        farenheit = farenheit * 1.8 + 32
        return Int(farenheit)
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
                if height < 750 && UIDevice.current.orientation.isLandscape {
                    cell.date.font = cell.date.font.withSize(13)
                    cell.mintemp.font = cell.mintemp.font.withSize(13)
                    cell.maxtemp.font = cell.maxtemp.font.withSize(13)
                } else {
                    cell.date.font = cell.date.font.withSize(23)
                    cell.mintemp.font = cell.mintemp.font.withSize(22)
                    cell.maxtemp.font = cell.maxtemp.font.withSize(22)
                }
                
                cell.date.text = String(weather[indexPath.row + 1].date)
                cell.weatherImage.image = weather[indexPath.row + 1].image
                
                if value == true {
                    cell.mintemp.text = String(weather[indexPath.row + 1].mintemp) + "º"
                    cell.maxtemp.text = String(weather[indexPath.row + 1].maxtemp) + "º"
                    
                    
                }
                else {
                    cell.mintemp.text = String(convertdegrees(with: weather[indexPath.row + 1].mintemp)) + "º"
                    cell.maxtemp.text = String(convertdegrees(with: weather[indexPath.row + 1].maxtemp)) + "º"
                    
                }
                
                
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}



