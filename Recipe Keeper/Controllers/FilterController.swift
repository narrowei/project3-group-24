//
//  FilterController.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class FilterController: UITableViewController {

    //creating cuisine array
    let cuisines = Cuisine.allCases
    var selectedCuisineIndex: Int?
    
    //creating time array
    let timeMark = [15,30,60,120]
    var selectedTimeIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    //setting number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //setting number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cuisines.count
        } else {
            return timeMark.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Filter by Cuisine"
        } else {
            return "Filter by Time"
        }
    }
    
    //building cells and check marks
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        if indexPath.section == 0 {
            let cuisine = cuisines[indexPath.row]
            cell.textLabel?.text = cuisine.rawValue
            if selectedCuisineIndex != nil && selectedCuisineIndex! == indexPath.row{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
            
        } else {
            let time = timeMark[indexPath.row]
            if time < 60 {
                cell.textLabel?.text = "Under \(time) minutes"
            } else if time == 60 {
                cell.textLabel?.text = "Under 1 hour"
            } else if time > 60 {
                let hour = time / 60
                cell.textLabel?.text = "Under \(hour) hours"
            }
            
            if selectedTimeIndex != nil && selectedTimeIndex! == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        return cell
    }
   
    // setting indexes of selected cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            if selectedCuisineIndex != nil && selectedCuisineIndex == indexPath.row {
                selectedCuisineIndex = nil
            } else {
                selectedCuisineIndex = indexPath.row
            }
   
        } else {
            
            if selectedTimeIndex != nil && selectedTimeIndex == indexPath.row {
                selectedTimeIndex = nil
            } else {
                selectedTimeIndex = indexPath.row
            }
            
        }
        tableView.reloadData()
    }


    // showing filtered data
    @IBAction func showSelectedAction(_ sender: Any) {
        //finding previous view controller and calling up its methods - kinda hack, TODO refactoring
        if let vcs = navigationController?.viewControllers{
            if let previousVC = vcs[vcs.count - 2] as? RecipeListController{
         
                previousVC.selectedCuisine = selectedCuisineIndex != nil ? cuisines[selectedCuisineIndex!].rawValue : nil
                previousVC.selectedTime = selectedTimeIndex != nil ? timeMark[selectedTimeIndex!] : nil
                previousVC.searchController.isActive = false
                previousVC.searchController.searchBar.text = nil
                previousVC.prepareDataForTableView()
                previousVC.tableView.reloadData()
           
            }
        }
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    //clearing the form
    @IBAction func clearAction(_ sender: Any) {
        selectedCuisineIndex = nil
        selectedTimeIndex = nil
        tableView.reloadData()
    }
}
