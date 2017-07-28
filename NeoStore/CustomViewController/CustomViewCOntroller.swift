//
//  CustomViewCOntroller.swift
//  NeoStore
//
//  Created by webwerks1 on 7/7/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class CustomViewCOntroller: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var CscrollView:UIScrollView? = nil
    var CtextField: UITextField? = nil
    var tap:UITapGestureRecognizer? = nil
    
    // MARK: Lifecycle methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tap!)
        tap?.delegate = self
        
        //addDoneButton(txtField: CtextField!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         setupKeyboard()
    }
    func setupKeyboard()
    {
        //addDoneButton(txtField: CtextField!)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    // MARK: TapGesture Methodes
    
    func tapAction()
    {
        self.view.endEditing(true)
    }
    
    //MARK: Keyboard handling Methodes
   
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        CscrollView?.contentInset = contentInsets
        CscrollView?.scrollIndicatorInsets = contentInsets
        
        var viewRect = view.frame
        viewRect.size.height -= keyboardSize.height
        if viewRect.contains((CtextField?.frame.origin)!) {
            
            let scrollPoint = CGPoint(x: 0,y: (CtextField?.frame.origin.y)! - keyboardSize.height)
            CscrollView?.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.CscrollView?.contentInset = contentInset
        self.resignFirstResponder()
    }
    
//    func addDoneButton(txtField: UITextField)
//        {
//            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0,y: 0,width: 320,height: 50))
//            doneToolbar.barStyle = UIBarStyle.default
//    
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(tapAction))
//    
//            var items = [UIBarButtonItem]()
//            items.append(flexSpace)
//            items.append(done)
//    
//            doneToolbar.items = items
//            doneToolbar.sizeToFit()
//    
//            txtField.inputAccessoryView = doneToolbar
//        }
    
    // Textfield and scrollview methodes 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

}
