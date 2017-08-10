//
//  WeatherViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBAction func change(_ sender: UIButton) {
        displayCity()
    }
       var change  = false
    var forecast: [Forecast] = []
    
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
        //   let itemSize = UIScreen.main.bounds.width/3 - 3
        //  let layout = UICollectionViewFlowLayout()
        //  layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //  layout.itemSize = CGSize(width: itemSize, height: 1.4*itemSize)
        //layout.minimumLineSpacing = 3
        //  layout.minimumInteritemSpacing = 2
        //  myCollectionview.collectionViewLayout = layout
        let parse = WeatherParser()
        
        guard let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=3&q=Lviv") else { return }
        parse.parse(with: url) { forecast,err in
            if let forecast1 = forecast as? [Forecast] {
                DispatchQueue.main.async {
                    
                    self.forecast = forecast1
                    self.currentTemp.text = "\(forecast1[0].currentTemp)º"
                    self.feelslike.text = "\(forecast1[0].feelsTemp)º"
                    self.today.text = forecast1[0].date
                    self.maxtemp1.text = "\(forecast1[0].maxtemp)º"
                    self.mintemp1.text = "\(forecast1[0].mintemp)º"
                    self.currentImg.image = forecast1[0].image
                 }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let parse = WeatherParser()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeatherCell else {
            return UICollectionViewCell() }
        let url = URL(string: "http://api.apixu.com/v1/forecast.json?key=c51487b2c3714e86be6142344173107&days=4&q=Lviv")
        parse.parse(with: url!) { forecast,err in
            if let forecast1 = forecast as? [Forecast] {
                DispatchQueue.main.async {
                    cell.date.text = String(forecast1[indexPath.row+1].date )
                    cell.mintemp.text = String(forecast1[indexPath.row+1].mintemp) + "º"
                    cell.maxtemp.text = String(forecast1[indexPath.row+1].maxtemp) + "º"
                    cell.weatherImage.image =  forecast1[indexPath.row+1].image
                    
                }
            }
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
        
        parse.parse(with: url) { forecast,err in
            if let forecast1 = forecast as? [Forecast] {
                DispatchQueue.main.async {
                    self.forecast = forecast1
                    self.currentTemp.text = "\(forecast1[0].currentTemp)º"
                    self.feelslike.text = "\(forecast1[0].feelsTemp)º"
                    self.today.text = forecast1[0].date
                    self.maxtemp1.text = "\(forecast1[0].maxtemp)º"
                    self.mintemp1.text = "\(forecast1[0].mintemp)º"
                }
            }
        }
    }
}

