//
//  WebserviceParsing.swift
//  NeoStore
//
//  Created by webwerks1 on 7/25/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import Foundation




public enum ClassTypes
{
    case User
    case Product
    case ProductList
}

public enum ResponseCode: Int {
    case Success = 200
    case InvalidData = 401
    case DataMissing = 400
    case WrongMethod = 404
    case InvalidAccessToken = 402
    case UpdateFailed = 500
}

class Parser
{
    class func responseStringParser(_ responseString: Dictionary<String, Any>,_ response: Any ,_ classType: ClassTypes) -> [Any]
    {
        var data: [Any] = []
        let httpStatus = response as? HTTPURLResponse
        //httpStatus?.statusCode == 200
        let code: ResponseCode = ResponseCode(rawValue: (httpStatus?.statusCode)!)!
        switch(code)
        {
        case .Success:
            switch(classType)
            {
            case .User:
                
                break
            case .Product:
                break
            case .ProductList:
                data = productListParser(responseString)
                break
            }
            break
        case .DataMissing:
            
            break
          
        default:
            break
        }
                return data
    }
    
    
    class func productListParser(_ responseString: Dictionary<String, Any>) -> [Product]
    {
        let productlist = responseString["data"] as! [Dictionary<String, Any>]
        var products: [Product] = []
        for pro in productlist
        {
        let product = Product(dict: pro)
            products.append(product)
        }
        return products
    }
    
    class func productParser(_ responseString: Dictionary<String, Any>) -> [Product]
    {
        
        let product = Product(dict: responseString["data"] as! Dictionary<String, Any>)
        print(product)
        return [product]
    }
}
