//
//  TextEditorController.swift
//  Reciper Keeper
//
//  Created by Roman Pavlov on 19/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

enum TextEditorMode {
    case ingredient
    case instruction
}



class TextEditorController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    

    @IBOutlet weak var details: UITableView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var step: UITextField!
    @IBOutlet weak var timerlabel: UILabel!
    
    var mode:TextEditorMode!
    var position = 0
    var data = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        details.dataSource = self
        details.delegate = self
        time.delegate = self
        time.keyboardType = .numberPad
        print(position)
        if mode == .ingredient {
            
            self.navigationItem.title = "Add Ingredient"
            self.label.text = "Ingredient"
            self.time.isHidden = true
            self.timerlabel.isHidden = true
        } else if mode == .instruction {
            
            self.navigationItem.title = "Step Instruction"
            self.label.text = "Instruction"
        }
        // Do any additional setup after loading the view.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    

    
    @IBAction func addItem(_ sender: Any) {
        if mode == .ingredient {
            if let text = step.text{
                if(!text.hasLetters){
                    MTAlert(title: "please enter a vaild ingredient", message: "", preferredStyle: .alert)
                        .addAction(title: "ok", style: .cancel) { (_) in
                        }.show()
                    return
                }
                data.append(text)
                DispatchQueue.main.async(execute: {
                    self.details.reloadData()
                })
                step.text = ""
                step.resignFirstResponder()
            }
        }else{
            if let text = step.text{
                if(!text.hasLetters){
                    MTAlert(title: "please enter a vaild instruction", message: "", preferredStyle: .alert)
                        .addAction(title: "ok", style: .cancel) { (_) in
                        }.show()
                    return
                }
                if let timer = time.text{
                    if(timer != ""){
                    data.append("\(text) (\(timer)mins)")
                    }else{
                        data.append(text)
                    }
                    DispatchQueue.main.async(execute: {
                        self.details.reloadData()
                    })
                }
                step.text = ""
                time.text = ""
                step.resignFirstResponder()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func saveAction(_ sender: Any) {
        if let vcs = navigationController?.viewControllers {
            if let previousVC = vcs[vcs.count - 2] as? AddRecipeController {
                if mode == .ingredient {
                    if (position == -1){
                        for ingredient in data{
                            previousVC.ingredients.append(ingredient)
                        }
                    }else{
                        previousVC.ingredients.insert(contentsOf: data, at: position+1)
                    }
                } else if mode == .instruction {
                    if (position == -1){
                        for instruction in data{
                            previousVC.instructions.append(instruction)
                        }
                    }else{
                        previousVC.instructions.insert(contentsOf: data, at: position+1)

                    }
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


