//
//  AddressCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/27/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var heading: UILabel!
    var deleteItemIndex = 0
    @IBOutlet var addressDetails: UILabel!
    @IBOutlet var radioButton: UIButton!
    override func awakeFromNib() {
              super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
