//
//  AddNameCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 22/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class AddNameCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var recipeName: UITextField!
    
    var name: String? {
        didSet {
            recipeName.placeholder = "My Recipe"
            if name != nil {
                recipeName.text = name
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
        recipeName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
