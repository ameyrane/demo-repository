//
//  StoreCell.swift
//  NeoStore
//
//  Created by webwerks1 on 6/30/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    @IBOutlet var locationName: UILabel!

    @IBOutlet var loctionAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
