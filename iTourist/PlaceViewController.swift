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
    
    var imageLoader = ImageDownloader()
    var searchActive: Bool = false {
        didSet{self.tableView.reloadData()}
    }
    var filteredPlaces: [Place] = []
    var places: [Place] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 145
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filteredPlaces.count : places.count
    }
    
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
        
        cell.name.text = place.name
        cell.adress.text = place.formattedAddress
        cell.phoneNum.text = place.internationalPhoneNumber
        cell.infoButton.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Navigation to place tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "PlaceProfileSeque" {
            let button = sender as! UIButton
            if let viewController = segue.destination as? PlacePrifileController {
                let place = searchActive ? filteredPlaces[button.tag] : places[button.tag]
                viewController.place = place
            }
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
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
        searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlaces = places.filter {$0.name?.lowercased().contains(searchText.lowercased()) == true}
        searchActive = filteredPlaces.count > 0
    }
}
