//
//  textCategory.swift
//  NeoStore
//
//  Created by webwerks1 on 7/12/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import Foundation
import UIKit

extension UITextField
{
   
    /// To validate email id
   func isValidEmail( ) -> Bool
    {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self.text)
        if !result
        {
            shake()
        }
        
        return result
    }
    /// Shake Animation fot text field
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    /// To validate Contact
    
    func isValidContact() -> Bool
    {
        let contactRegEx = "[0-9]{10}"
        let contactTest = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        let result = contactTest.evaluate(with: self.text)
        if !result
        {
            shake()
        }
        return result
    }
    
    /// To Validate Password
    func isValidPassword() -> Bool
    {
        let passwordRegEx = "[A-Z0-9a-z]{6,10}"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: self.text)
       
        if !result
        {
            shake()
        }
        return result
    }
    
    /// To Validte Text Field (eg. Contains only letters A-Z and a-z)
    
    func isValidName() -> Bool
    {
        let nameRegEx = "[A-Za-z,.\" ]{2,15}"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        let result = nameTest.evaluate(with: self.text)
        if !result
        {
            shake()
        }
        return result
    }
    
    /// To Validte Text Field (eg. is Not empty)
    func isNotEmpty() -> Bool
    {
        if self.text == ""
        {
            shake()
            return false
        }
        return true
    }
    
    /// Extension to UITextField to get Text without whitespaces
    func textWithoutWhiteSpaces() -> String
    {
        if (self.text as AnyObject is NSNull) {
            return ""
        }
        if (self.text as AnyObject).isEqual("<null>") || (self.text as AnyObject).isEqual("(null)") {
            return ""
        }
        let strVal: String = (self.text as AnyObject).trimmingCharacters(in: CharacterSet.whitespaces)
        if (strVal.characters.count ) == 0 {
            return ""
        }
        else {
            return strVal
        }

    }
    
    /// Extension to textfield to check valid quantity
    func isvalidQuantity() -> Bool
    {
        let contactRegEx = "[1-8]{1}"
        let contactTest = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        let result = contactTest.evaluate(with: self.text)
        if !result
        {
            shake()
        }
        return result
    }
    
    /// Extension to textfield  to valid number (not contains any letter and symbol)
    func isValidNumber() -> Bool
    {
        let contactRegEx = "[0-9]{2,8}"
        let contactTest = NSPredicate(format:"SELF MATCHES %@", contactRegEx)
        let result = contactTest.evaluate(with: self.text)
        if !result
        {
            shake()
        }
        return result
    }
    
}
