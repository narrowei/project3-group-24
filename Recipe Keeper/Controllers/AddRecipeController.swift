//
//  RecipeController.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 10/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit
import RealmSwift

class AddRecipeController: UITableViewController, UITextFieldDelegate {
    var currentRecipe: Recipe?
    var items = [AddViewModelItem]()
    
    var name: String?
    var cuisine: String?
    var time: Int?
    var ingredients = [String]()
    var instructions = [String]()
    
    @objc func tapDetected(){
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap out gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddRecipeController.tapDetected))
        view.addGestureRecognizer(tap)
        
        // Generate view model
        let addViewModel = AddViewModel()
        items = addViewModel.items
        
        // Specify title and row height
        // self.navigationItem.title = currentRecipe.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 40
        tableView?.register(AddNameCell.nib, forCellReuseIdentifier: AddNameCell.identifier)
        tableView?.register(SelectCuisineCell.nib, forCellReuseIdentifier: SelectCuisineCell.identifier)
        tableView?.register(EstimateTimeCell.nib, forCellReuseIdentifier: EstimateTimeCell.identifier)
        tableView?.register(AddIngredientCell.nib, forCellReuseIdentifier: AddIngredientCell.identifier)
        tableView?.register(AddInstructionCell.nib, forCellReuseIdentifier: AddInstructionCell.identifier)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items[section].type == .ingredients {
            print(ingredients.count)
            return (ingredients.count + 1)
        } else if items[section].type == .instruction {
            return (instructions.count + 1)
        } else {
            return items[section].rowCount
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        // Generate view for each section
        let item = items[indexPath.section]
        switch item.type {
            
        // Generate view for Ingredient section
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddNameCell.identifier, for: indexPath) as? AddNameCell {
                cell.name = name
                let recipeName = cell.viewWithTag(1) as! UITextField
                recipeName.delegate = self
                return cell
            }
            
        // Generate view for Instruction section
        case .cuisine:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelectCuisineCell.identifier, for: indexPath) as? SelectCuisineCell {
                cell.cuisine = cuisine
                let cuisineType = cell.viewWithTag(2) as! UITextField
                cuisineType.delegate = self
                return cell
            }
            
        case .time:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EstimateTimeCell.identifier, for: indexPath) as? EstimateTimeCell {
                cell.time = time
                let estimatedTime = cell.viewWithTag(3) as! UITextField
                estimatedTime.delegate = self
                return cell
            }
            
        case .ingredients:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddIngredientCell.identifier, for: indexPath) as? AddIngredientCell {
                let buttonAddIngredient = cell.viewWithTag(4) as! UIButton
                buttonAddIngredient.removeTarget(nil, action: nil, for: .allEvents)
                buttonAddIngredient.addTarget(self, action: #selector(AddRecipeController.addIngredientAction), for: .touchUpInside)
                let ingredient = cell.viewWithTag(5) as! UILabel
                if indexPath.row < ingredients.count {
                    ingredient.text = ingredients[indexPath.row]
                }
                //print("index path row is\(indexPath.row), count array is \(ingredients.count)")
                return cell
            }
            
        case .instruction:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddInstructionCell.identifier, for: indexPath) as? AddInstructionCell {
                let buttonAddInstruction = cell.viewWithTag(6) as! UIButton
                buttonAddInstruction.removeTarget(nil, action: nil, for: .allEvents)
                buttonAddInstruction.addTarget(self, action: #selector(AddRecipeController.addInstructionAction), for: .touchUpInside)
                let instruction = cell.viewWithTag(7) as! UILabel
                if indexPath.row < instructions.count {
                    instruction.text = instructions[indexPath.row]
                }
                return cell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            name = textField.text ?? ""
        } else if textField.tag == 2 {
            cuisine = textField.text ?? ""
        } else if textField.tag == 3 {
            if let timeString = textField.text {
                let array = timeString.split(separator: " ")
                if array[1] == "minutes" {
                    time = Int(array[0])
                } else {
                    time = Int(array[0])! * 60
                }
            } else {
                time = 0
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
    }
 */
    @objc func addIngredientAction(){
        let textEditor = storyboard?.instantiateViewController(withIdentifier: "TextEditorController") as! TextEditorController
        textEditor.mode = .ingredient
        navigationController?.pushViewController(textEditor, animated: true)
        
    }
    //actions when add instruction button is tapped
    
    @objc func addInstructionAction(){
        let textEditor = storyboard?.instantiateViewController(withIdentifier: "TextEditorController") as! TextEditorController
        textEditor.mode = .instruction
        navigationController?.pushViewController(textEditor, animated: true)
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        let realm = try! Realm()
        
        let realmInstructions = List<Step>()
        var i = 1
        for instruction in instructions{
            let realmInstruction = Step(description: instruction, needTimer: false, timer:0)
            realmInstructions.append(realmInstruction)
            i += 1
        }
        
        let realmIngredients = List<String>()
        for ingredient in ingredients{
            realmIngredients.append(ingredient)
        }
        
        let recipe = Recipe(name: name!, time: time!, cuisine: cuisine!, ingredients: realmIngredients, instruction: realmInstructions)
        try! realm.write {
            realm.add(recipe, update: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
