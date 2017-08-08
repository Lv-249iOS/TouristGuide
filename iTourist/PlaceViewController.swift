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
    
    var imageLoader = ImageCacheLoader()
    var searchActive: Bool = false
    var filteredPlaces: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 145
        
        PlacesManager.shared.getPlaces() {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredPlaces.count : PlacesManager.shared.listOfPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? PlaceCell else { return UITableViewCell() }
        
        let place = searchActive ? filteredPlaces[indexPath.row] : PlacesManager.shared.listOfPlaces[indexPath.row]
        
        if let urls = place.photosRef {
            imageLoader.obtainImageWithPath(imagePath: urls[0]) { image in
                if let _ = tableView.cellForRow(at: indexPath) {
                    cell.placeImage.image = image
                }
            }
        }
        
        cell.name.text = place.name
        cell.adress.text = place.formattedAddress
        cell.phoneNum.text = place.internationalPhoneNumber
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Navigation to first place tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PlacePrifileController {
            viewController.place = PlacesManager.shared.listOfPlaces.first
        }
    }
}

// extension for searchBar, we're checking what user doing
extension PlaceViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlaces = PlacesManager.shared.listOfPlaces.filter {$0.name?.lowercased().contains(searchText.lowercased()) == true}
        filteredPlaces.count == 0 ? (searchActive = false) :  (searchActive = true)
        
        self.tableView.reloadData()
    }
}
