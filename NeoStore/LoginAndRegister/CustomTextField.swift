//
//  CustomTextField.swift
//  NeoStore
//
//  Created by webwerks1 on 6/20/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

//import UIKit
//
////@IBDesignable
//
//extension UITextField
//{
//    
//}
//
//class CustomTextField: UITextField {
//
//    @IBInspectable var leftImage: UIImage? {
//        didSet {
//            updateView()
//        }
//    }
//    
//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//        var textRect = super.leftViewRect(forBounds: bounds)
//        leftPadding += 10
//        textRect.origin.x += leftPadding
//        
//        return textRect
//    }
//    
//    @IBInspectable var leftPadding: CGFloat = 0
//        {
//            didSet
//            {
//                updateView()
//        }
//    }
//    
//    
//    
//    @IBInspectable var color: UIColor = UIColor.lightGray {
//        didSet {
//            updateView()
//        }
//    }
//    
////    @IBInspectable var cornerRadious: CGFloat = 3.0
////        {
////        didSet
////        {
////            updateView()
////        }
////    }
//
//    
//    func updateView() {
//        if let image = leftImage {
//            
//            self.layer.borderColor = UIColor.white.cgColor
//            self.layer.borderWidth = 1.0
//            self.clipsToBounds = true
//            self.layer.cornerRadius = 3.0
//            leftViewMode = UITextFieldViewMode.always
//           
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//            imageView.image = image
//            imageView.frame = CGRect(x: 0, y: 0, width: image.size.width + 50, height: image.size.height)
//            imageView.tintColor = color
//            leftView = imageView
//        } else {
//            leftViewMode = UITextFieldViewMode.never
//            leftView = nil
//        }
//  
//        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
//    }
//}
