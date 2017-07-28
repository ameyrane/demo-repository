//
//  CustomTextView.swift
//  NeoStore
//
//  Created by webwerks1 on 6/26/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class CustomTextView: UITextField {

   
     var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        let leftPadding: CGFloat = 10.0
        textRect.origin.x = textRect.origin.x + leftPadding
        
        return textRect
    }
    
//   var leftPadding: CGFloat = 0
//        {
//        didSet
//        {
//            updateView()
//        }
//    }
//    
    
    
//    var color: UIColor = UIColor.lightGray {
//        didSet {
//            updateView()
//        }
//    }
    
    func updateView() {
       // if self.placeholder
        self.attributedPlaceholder = NSAttributedString(string: (self.placeholder != nil ? self.placeholder: self.text)!, attributes: [NSForegroundColorAttributeName: UIColor.white])
        if let image = UIImage(named: self.accessibilityLabel!) {
            self.clearsOnBeginEditing = true
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.0
            self.clipsToBounds = true
           // self.layer.cornerRadius = 3.0
            leftViewMode = UITextFieldViewMode.always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            
            imageView.tintColor = UIColor.white
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: UIColor.white])
    }

}
