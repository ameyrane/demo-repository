//
//  OrderItem.swift
//  NeoStore
//
//  Created by webwerks1 on 6/29/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class OrderItem: UITableViewCell {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    
    @IBOutlet var itemCost: UILabel!
    @IBOutlet var itemCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
