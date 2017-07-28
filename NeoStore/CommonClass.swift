//
//  CommonClass.swift
//  NeoStore
//
//  Created by webwerks1 on 7/17/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class CommonClass: NSObject {
    
    class func setImage(_ url: URL, successBlock: @escaping (_ image: UIImage) -> Void)
    {
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            if data != nil
            {
                let image = UIImage(data: data!)
                if image != nil
                {
                    DispatchQueue.main.async(execute: {() -> Void in
                      successBlock(image!)
                    })
                }
            }
        })
        task.resume()
    }
    
    
    /// Function to add values in user Defaults
    class func addValuesToUserDefaults(dictionary: Dictionary<String, Any>, key: String)
    {
        let user = User.init(userDict: (dictionary as NSDictionary))
        let userdefault = UserDefaults.standard
        userdefault.set(user.getAsDictionary(), forKey: key)
    }
    
    /// Function to get values from userdefaults
    class func getValuesFromUserDefaults(key: String) -> Dictionary<String, Any>
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: key) as! Dictionary<String, Any>
       
        return user
    }
    
    // Function to edit numberofCart Items in uderDefaults
    class func editValuesInUserDefaults(value: String,keyForEdit:String, key: String)
    {
        let userdefault = UserDefaults.standard
        let userDictionary = userdefault.object(forKey: key) as! Dictionary<String, Any>
        //userDictionary[keyForEdit] = value
        let dataDictionary = ["user_data": userDictionary, keyForEdit : value] as [String : Any]
        print("000000")
        print(dataDictionary)
        print("000000")
        let user = User.init(userDict: dataDictionary as NSDictionary)
        userdefault.set(user.getAsDictionary(), forKey: key)
    }
    
    // Function to fetching user details from webservice
    class func updateUserDetails(accessToken: String, view: UIView)
    {
       
        print(accessToken)
        let header = ["access_token": accessToken] as Dictionary<String, Any>
        
       
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_ACCOUNT_DETAILS, param: [:], headerValue: header, isHud: true, hudView: view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                CommonClass.addValuesToUserDefaults(dictionary: (responseUrl["data"] as! Dictionary<String, Any>), key: "logged_user")
              
            }
            
        }, errorBlock: {
            error in
            
        })
       
    }
    
    
}


struct WebservicesUrl
{
    static let WS_BASE_URL = "http://staging.php-dev.in:8844/trainingapp/api/"
    static let WS_User_REGISTER = "users/register"
    static let WS_USER_LOGIN = "users/login"
    static let WS_FORGOT_PASSWORD = "users/forgot"
    static let WS_USER_CHANGE_PASSWORD = "users/change"
    static let WS_UPDATE_ACCOUNT = "users/update"
    static let WS_ACCOUNT_DETAILS = "users/getUserData"
    static let WS_PRODUCT_LIST = "products/getList"
    static let WS_PRODUCT_DETAILS = "products/getDetail"
    static let WS_PRODUCT_RATING = "products/setRating"
    static let WS_ADD_TO_CART = "addToCart"
    static let WS_EDIT_CART = "editCart"
    static let WS_BDELETE_CART = "deleteCart"
    static let WS_CART_ITEMS = "cart"
    static let WS_ORDER = "order"
    static let WS_ORDER_LIST = "orderList"
    static let WS_ORDER_Details = "orderDetail"
}

