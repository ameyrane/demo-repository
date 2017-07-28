//
//  Validations.swift
//  NeoStore
//
//  Created by webwerks1 on 7/17/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class Validations: NSObject {
 
    /// Validation for Data
    class func textWithoutWhiteSpaces(_ val: Any) -> String
    {
        if (val as AnyObject is NSNull) {
            return ""
        }
        if (val as AnyObject).isEqual("<null>") || (val as AnyObject).isEqual("(null)") {
            return ""
        }
        let strVal: String = (val as AnyObject).trimmingCharacters(in: CharacterSet.whitespaces)
        if (strVal.characters.count ) == 0 {
            return ""
        }
        else {
            return strVal
        }
    }
}
