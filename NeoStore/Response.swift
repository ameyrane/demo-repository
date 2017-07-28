//
//  Response.swift
//  NeoStore
//
//  Created by webwerks1 on 7/26/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class Response: NSObject {
    var response : URLResponse?
   
    var responseString: Dictionary<String, Any>?
    
    init(_ res: URLResponse,_ resString: Dictionary<String, Any>?)
    {
        self.response = res
        
        self.responseString = resString
    }
}
