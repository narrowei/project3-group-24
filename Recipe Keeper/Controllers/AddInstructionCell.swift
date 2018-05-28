//
//  AddInstructionCell.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 22/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

class AddInstructionCell: UITableViewCell {
    
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
