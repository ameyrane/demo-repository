//
//  CustomButton.swift
//  NeoStore
//
//  Created by webwerks1 on 6/22/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

   @IBInspectable var cornerRadious: CGFloat = 3.0
        {
        didSet{
            update()
        }
    }
    
    func update()
    {
        self.layer.cornerRadius = cornerRadious
    }
  
    

}
