//
//  LeftMenuTableCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/26/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class LeftMenuTableCell: UITableViewCell {

    @IBOutlet var menuName: UILabel!
    @IBOutlet var menuImage: UIImageView!
    @IBOutlet var numberOfItemsInCart: UILabel!
    override func awakeFromNib() {
       
        super.awakeFromNib()
       
                numberOfItemsInCart.layer.masksToBounds = false
                numberOfItemsInCart.layer.cornerRadius = numberOfItemsInCart.frame.height / 2
                numberOfItemsInCart.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
