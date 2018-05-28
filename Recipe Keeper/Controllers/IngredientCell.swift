//
//  IngredientCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 15/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var IngredientTag: UIView!
    @IBOutlet weak var IngredientDescription: UILabel!
    @IBOutlet weak var Action: UIButton!
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        Action.isSelected = !Action.isSelected
        actionState = Action.isSelected
    }
    
    var item: String? {
        didSet {
            IngredientDescription.text = item
        }
    }
    var stepNumber: Int? {
        didSet {
            if (stepNumber! + 1) % 3 == 0 {
                IngredientTag.backgroundColor = UIColor.MyTheme.pink
            } else if (stepNumber! + 1) % 3 == 1 {
                IngredientTag.backgroundColor = UIColor.MyTheme.yellow
            } else if (stepNumber! + 1) % 3 == 2{
                IngredientTag.backgroundColor = UIColor.MyTheme.orange
            }
        }
    }
    
    var actionState: Bool? {
        didSet{
            Action.isSelected = actionState!
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
