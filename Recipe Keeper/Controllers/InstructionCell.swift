//
//  InstructionCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 13/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    @IBOutlet weak var StepTag: UIView!
    @IBOutlet weak var StepDescription: UILabel!
    @IBOutlet weak var Action: UIButton!
    @IBAction func actionButtonTapped(_ sender: Any) {
        Action.isSelected = !Action.isSelected
        //item?.status = Action.isSelected
    }
    
    
    var item: Step? {
        didSet {
            StepDescription.text = item?.stepDescription
            //Action.isSelected = (item?.status)!
        }
    }
    
    var stepNumber: Int? {
        didSet {
            if (stepNumber! + 1) % 3 == 0 {
                StepTag.backgroundColor = UIColor.MyTheme.pink
            } else if (stepNumber! + 1) % 3 == 1 {
                StepTag.backgroundColor = UIColor.MyTheme.yellow
            } else if (stepNumber! + 1) % 3 == 2 {
                StepTag.backgroundColor = UIColor.MyTheme.orange
            }
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
        super.setSelected(false, animated: false)
        
        
        
        // Configure the view for the selected state
    }
    
}
