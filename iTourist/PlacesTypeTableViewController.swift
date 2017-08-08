//
//  PlacesTypeTableViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacesTypeTableViewController: UITableViewController {
    // create var with types
    var places: [Place] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlacesManager.shared.getPlaces() {
            // get from DB Types
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        places = []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // types.count from db
        return 17
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeOfPlaceCell", for: indexPath)
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "restaurant"
        case 1: cell.textLabel?.text = "cafe"
        case 2: cell.textLabel?.text = "lodging"
        case 3: cell.textLabel?.text = "parking"
        case 4: cell.textLabel?.text = "church"
        case 5: cell.textLabel?.text = "airport"
        case 8: cell.textLabel?.text = "bakery"
        case 9: cell.textLabel?.text = "food"
        case 10: cell.textLabel?.text = "bar"
        case 11: cell.textLabel?.text = "movie_theater"
        case 12: cell.textLabel?.text = "museum"
        case 13: cell.textLabel?.text = "night_club"
        case 14: cell.textLabel?.text = "park"
        case 15: cell.textLabel?.text = "store"
        default: cell.textLabel?.text = "point_of_interest"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlaceViewController") as! PlaceViewController
        self.navigationController?.pushViewController(vc, animated: true)
        if let selectedRow = tableView.indexPathsForSelectedRows {
            vc.navigationItem.title = self.tableView.cellForRow(at: selectedRow[0])?.textLabel?.text
            
            for place in PlacesManager.shared.listOfPlaces {
                guard let type = self.tableView.cellForRow(at: selectedRow[0])?.textLabel?.text else { return }
                if place.typeOfPlace?.contains(type) == true {
                    self.places.append(place)
                }
            }
            
            vc.places = places
        }
    }
    
}
