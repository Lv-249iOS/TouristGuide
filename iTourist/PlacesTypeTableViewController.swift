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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load from database all types
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // types.count
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeOfPlaceCell", for: indexPath)
        
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Restorant"
        case 1: cell.textLabel?.text = "Cafe"
        case 2: cell.textLabel?.text = "Parking"
        case 3: cell.textLabel?.text = "Hotel"
        default: cell.textLabel?.text = "Point of interes"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlaceViewController") as! PlaceViewController
        self.navigationController?.pushViewController(vc, animated: true)
        if let selectedRow = tableView.indexPathsForSelectedRows {
            vc.navigationItem.title = self.tableView.cellForRow(at: selectedRow[0])?.textLabel?.text
        }
    }
    
}
