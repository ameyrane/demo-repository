//
//  Product.swift
//  NeoStore
//
//  Created by webwerks1 on 7/17/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class Product: NSObject {
    var cost: String? = ""
    var created: String? = ""
    var des: String? = ""
    var id: String? = ""
    var modified: String? = ""
    var name: String? = ""
    var producer: String? = ""
    var rating: Int? = 0
    var productImage = ""
    var productImages : [Dictionary<String, Any>]? = []
    
    init(dict: Dictionary<String, Any>)
    {
     
        self.cost = "\(dict["cost"]!)"
        self.created = "\(dict["created"]!)"
        self.des = "\(dict["description"]!)"
        self.id = "\(dict["id"]!)"
        self.modified = "\(dict["modified"]!)"
        self.name = "\(dict["name"]!)"
        self.producer = "\(dict["producer"]! )"
        self.rating = dict["rating"]! as? Int
        print(dict["product_images"]! as! String)
        if dict["product_images"]! is String
        {
            self.productImage = (dict["product_images"]! as? String)!
        }
        else
        {
        self.productImages = dict["product_images"]! as? [Dictionary<String, Any>]
        }
    }
    
}
