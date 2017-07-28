//
//  Webservices.swift
//  NeoStore
//
//  Created by webwerks1 on 7/13/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

//struct WebservicesUrl
//{
//    static let WS_BASE_URL = "http://staging.php-dev.in:8844/trainingapp/api/"
//    static let WS_User_REGISTER = "users/register"
//    static let WS_USER_LOGIN = "users/login"
//    static let WS_FORGOT_PASSWORD = "users/forgot"
//    static let WS_USER_CHANGE_PASSWORD = "users/change"
//    static let WS_UPDATE_ACCOUNT = "users/update"
//    static let WS_ACCOUNT_DETAILS = "users/getUserData"
//    static let WS_PRODUCT_LIST = "products/getList"
//    static let WS_PRODUCT_DETAILS = "products/getDetail"
//    static let WS_PRODUCT_RATING = "products/setRating"
//    static let WS_ADD_TO_CART = "addToCart"
//    static let WS_EDIT_CART = "editCart"
//    static let WS_BDELETE_CART = "deleteCart"
//    static let WS_CART_ITEMS = "cart"
//    static let WS_ORDER = "order"
//    static let WS_ORDER_LIST = "orderList"
//    static let WS_ORDER_Details = "orderDetail"
//}

class Webservices: NSObject {
    
    static func callPOSTServiceMethod(ServiceName:String, param:Dictionary<String, Any> , headerValue: Dictionary<String, Any>, isHud:Bool, hudView: UIView, successBlock:@escaping (_ response:Any, _ responseStr: Dictionary<String, Any> )->Void, errorBlock:@escaping (_ error:Any)->Void)  -> Void{
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        // 2) URL String
        
        var urlStr = String()
        urlStr.append(WebservicesUrl.WS_BASE_URL)
        urlStr.append(ServiceName)
        let encodedUrl = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let serverUrl: URL = URL(string: (encodedUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!)!
        // 3) create request object
        var request : URLRequest = URLRequest(url: serverUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 180.0)
        
        // 4) create string from parameters
        var paramStr : String = String()
        if param.count > 0{
            let keysArray = param.keys
            for  key in keysArray
            {
                if paramStr.isEmpty{
                    paramStr.append("\(key)=\(param[key]! as! String)")
                }else{
                    paramStr.append("&\(key)=\(param[key]! as! String)")
                }
            }
        }
        
        let postData:Data = paramStr.data(using: .utf8)!
        let postLength = "\(postData.count)"
        // set request object
        request.httpMethod = "POST"
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
        if !(headerValue.isEmpty){
            let allkeys = headerValue.keys
            for key in allkeys {
                request.setValue(headerValue[key] as! String?, forHTTPHeaderField: key)
            }
        }
        
        // get data from url
        
        let postDataTask : URLSessionDataTask = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if data != nil && error == nil{
                do {
                    let responseStr = try JSONSerialization.jsonObject(with: (data)!, options: .mutableContainers) as! Dictionary<String, Any>
                    print("\(responseStr)")
                    
                    DispatchQueue.main.async{
                    
                        successBlock(response ?? "",responseStr)
                    }
                }
                catch let error as NSError
                {
                    print("Failed to load: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        
                        errorBlock(error.localizedDescription)
                    }
                }
            }
        })
        postDataTask.resume()
        
    }
    
   static func callGetDataWithMethod(ServiceName:String,param:Dictionary<String, Any> , headerValue: Dictionary<String, Any>, isHud:Bool, hudView: UIView, successBlock:@escaping (_ response:Any, _ responseStr: Dictionary<String, Any> )->Void, errorBlock:@escaping (_ error:Any)->Void)  -> Void  {
        
        var urlString = String()
        urlString.append(WebservicesUrl.WS_BASE_URL)
        urlString.append(ServiceName)
        
        if param.count > 0{
            var i = 0;
            let keysArray = param.keys
            for  key in keysArray {
                if i == 0{
                     i += 1
                    urlString.append("?\(key)=\(param[key] as! String)")
                }else{
                    urlString.append("&\(key)=\(param[key] as! String)")
                }
               
            }
        }
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = NSMutableURLRequest(url: url! as URL)
        
        if headerValue.count > 0{
            for (key,param) in headerValue{
                request.addValue(param as! String, forHTTPHeaderField: key)
            }
        }
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if data != nil && error == nil
            {
                do {
                    //let d = String.init(data: data!, encoding: .utf8)
                
                    let responseStr  = try JSONSerialization.jsonObject(with: (data)!, options: .mutableContainers) as! Dictionary<String, Any>
                    
                    DispatchQueue.main.async {
                        successBlock(response ?? "",responseStr)
                    }
                } catch let parsingerror as NSError
                {
                    print("Failed to load: \(parsingerror.localizedDescription)")
                    DispatchQueue.main.async {
                        
                        errorBlock(parsingerror.localizedDescription)
                    }
                }
            }
            else{
                print("Error is \(String(describing: error))")
            }
        })
        dataTask.resume()
    }
    
    
    static func callGetMethod(ServiceName:String,param:Dictionary<String, Any> , headerValue: Dictionary<String, Any>, isHud:Bool, hudView: UIView, successBlock:@escaping (_ responseObj: Response)->Void, errorBlock:@escaping (_ error:Any)->Void)  -> Void  {
        
        var urlString = String()
        urlString.append(WebservicesUrl.WS_BASE_URL)
        urlString.append(ServiceName)
        
        if param.count > 0{
            var i = 0;
            let keysArray = param.keys
            for  key in keysArray {
                if i == 0{
                    i += 1
                    urlString.append("?\(key)=\(param[key] as! String)")
                }else{
                    urlString.append("&\(key)=\(param[key] as! String)")
                }
                
            }
        }
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = NSMutableURLRequest(url: url! as URL)
        
        if headerValue.count > 0{
            for (key,param) in headerValue{
                request.addValue(param as! String, forHTTPHeaderField: key)
            }
        }
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if data != nil && error == nil
            {
                do {
                    //let d = String.init(data: data!, encoding: .utf8)
                    
                    let responseStr  = try JSONSerialization.jsonObject(with: (data)!, options: .mutableContainers) as! Dictionary<String, Any>
                    let responseObj = Response(response!, responseStr)
                    DispatchQueue.main.async {
                        successBlock(responseObj)
                    }
                } catch let parsingerror as NSError
                {
                    print("Failed to load: \(parsingerror.localizedDescription)")
                    DispatchQueue.main.async {
                        
                        errorBlock(parsingerror.localizedDescription)
                    }
                }
            }
            else{
                print("Error is \(String(describing: error))")
            }
        })
        dataTask.resume()
    }

}
