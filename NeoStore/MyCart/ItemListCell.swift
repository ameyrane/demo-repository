//
//  ItemListCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/22/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class ItemListCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var itemDescription: UILabel!
    @IBOutlet var buttonDropDown: UIButton!
    
    @IBOutlet var cViewOutlet: UIView!
    
    override func awakeFromNib() {
    
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
