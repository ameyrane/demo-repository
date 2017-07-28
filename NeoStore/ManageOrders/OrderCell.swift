//
//  OrderCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/29/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet var orderTotal: UILabel!
    @IBOutlet var orderDate: UILabel!
    @IBOutlet var orderID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
