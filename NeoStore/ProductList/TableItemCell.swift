//
//  TableItemCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/21/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import Cosmos
class TableItemCell: UITableViewCell {

    var productId = 0
    @IBOutlet var itemRating: CosmosView!
    @IBOutlet var itemDesc: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var priceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
