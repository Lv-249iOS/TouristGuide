//
//  PlacesTypeTableViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacesTypeTableViewController: UITableViewController {
    
    /// Set background to tableview and hiding status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        let imageView = UIImageView(image: SettingsManager.shared.currentBackgroundImage)
        self.tableView.backgroundView = imageView
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeOfPlaceCell", for: indexPath)
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "restaurant"
        case 1: cell.textLabel?.text = "cafe"
        case 2: cell.textLabel?.text = "lodging"
        case 3: cell.textLabel?.text = "church"
        case 4: cell.textLabel?.text = "airport"
        case 5: cell.textLabel?.text = "food"
        case 6: cell.textLabel?.text = "bar"
        case 7: cell.textLabel?.text = "museum"
        case 8: cell.textLabel?.text = "night_club"
        case 9: cell.textLabel?.text = "park"
        case 10: cell.textLabel?.text = "store"
        default: cell.textLabel?.text = "point_of_interest"
        }
        
        return cell
    }
    
    /// Here we push our current viewController into navigationController hierarchy and set name of the current place as a navigationItem
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlaceViewController") as? PlaceViewController else { return }

        self.navigationController?.pushViewController(vc, animated: true)
        if let selectedRow = tableView.indexPathsForSelectedRows {
            SettingsManager.shared.makeSoundIfNeeded()
            vc.navigationItem.title = self.tableView.cellForRow(at: selectedRow[0])?.textLabel?.text
        }
    }
}
