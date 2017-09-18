//
//  PlaceViewController.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlaceViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var imageLoader = ImageManager.shared
    var filteredPlaces: [Place] = []
    var places: [Place] = []
    var placesList = PlacesList.shared
    
    var searchActive: Bool = false {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func initPlaces() {
        placesList.getPlaces(with: [AppModel.shared.getLocation()]) { places in
            guard let placesArr = places else { return }
            for (_, places) in placesArr {
                guard let type = self.navigationItem.title, let places = places else { return }
                for place in places {
                    if place.typeOfPlace?.contains(type) == true {
                        self.places.append(place)
                    }
                }
            }
            self.sortPlacesIfNeeded()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func sortPlacesIfNeeded() {
        if let value = UserDefaults.standard.value(forKey: PathForSettingsKey.sortPlaces.rawValue) as? Bool,
            value == true {
            self.places.sort(by: { $0.name! > $1.name! })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPlaces()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 145 // Approximate height of row
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        let imageView = UIImageView(image: SettingsManager.shared.currentBackgroundImage)
        
        self.tableView.backgroundView = imageView
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    /// Return only all places or filtered places
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredPlaces.count : places.count
    }
    
    /// Set first image of place or filtered place for every cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else { return UITableViewCell() }
        
        let place = searchActive ? filteredPlaces[indexPath.row] : places[indexPath.row]
        if let urls = place.photosRef {
            imageLoader.obtainImage(with: urls[0]) { image in
                if let _ = tableView.cellForRow(at: indexPath) {
                    cell.placeImage.image = image
                }
            }
        }
        
        cell.delegate = self
        cell.configureCell(with: place)
        // Set information for place and set tag for infoButton equal indexPath in this cell row
//        cell.name.text = place.name
//        cell.adress.text = place.formattedAddress
//        cell.phoneNum.text = place.internationalPhoneNumber
//        cell.infoButton.tag = indexPath.row
        
        return cell
    }
    
    /// We need automaticDimension to make height of row fits to value inside
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
    /// This function tells that user ended insert something to searchBar and keyboard should be hidden
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

/// Extension for searchBar, we're checking what user doing
extension PlaceViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
    }
    
    /// Filter places when first letter no was insert
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlaces = places.filter {$0.name?.lowercased().contains(searchText.lowercased()) == true}
        searchActive = filteredPlaces.count > 0
    }
}

extension PlaceViewController: MyCellDelegate {
    func cellInfoDidClicked(for place: Place) {
        let placeView = UIStoryboard(name: "PlacesType", bundle: nil)
        let nextViewController = placeView.instantiateViewController(withIdentifier: "PlacePrifileController") as! PlaceProfileViewController
        nextViewController.place = place
        self.present(nextViewController, animated:true, completion:nil)
        SettingsManager.shared.makeSoundIfNeeded()
    }
}
