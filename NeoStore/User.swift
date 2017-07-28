//
//  User.swift
//  NeoStore
//
//  Created by webwerks1 on 7/17/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class User: NSObject {
    var token: String
    var email: String
    var last_name : String
    var first_name : String
    var country_id : String
    var created : String
    var dob : String
    var gender : String
    //var is_active : String
    var modified : String
    var phone_no : String
    var username : String
    var totalCartItems: String
    init(userDict: NSDictionary)
    {
        let dict = userDict.value(forKey: "user_data") as! NSDictionary
        self.totalCartItems = "\(String(describing: userDict.value(forKey: "total_carts")!))"
        self.token = Validations.textWithoutWhiteSpaces(dict["access_token"]!)
        self.email = Validations.textWithoutWhiteSpaces(dict.value(forKey: "email")!)
        self.last_name = Validations.textWithoutWhiteSpaces(dict.value(forKey: "first_name")!)
        self.first_name = Validations.textWithoutWhiteSpaces(dict.value(forKey: "last_name")! )
        self.country_id = Validations.textWithoutWhiteSpaces(dict.value(forKey: "country_id")! )
        self.created = Validations.textWithoutWhiteSpaces(dict.value(forKey: "created")!)
        self.dob = Validations.textWithoutWhiteSpaces(dict.value(forKey: "dob")!)
        self.gender = Validations.textWithoutWhiteSpaces(dict.value(forKey: "gender")!)
        //self.is_active = (dict.value(forKey: "is_active") as! String)
        self.modified = Validations.textWithoutWhiteSpaces(dict.value(forKey: "modified")! )
        self.phone_no = Validations.textWithoutWhiteSpaces(dict.value(forKey: "phone_no")! )
        self.username = Validations.textWithoutWhiteSpaces(dict.value(forKey: "username")! )
        
    }
    
    func getAsDictionary() -> Dictionary<String, Any>
    {
        let userDic = ["access_token":token,"email":email,"first_name":first_name,"last_name":last_name,"country_id":country_id,"created":created,"dob":dob,"gender":gender,"modified":modified,"phone_no":phone_no,"username":username, "total_carts":totalCartItems]
        return userDic
    }
    
}
