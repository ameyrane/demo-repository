//
//  Register.swift
//  NeoStore
//
//  Created by webwerks1 on 6/21/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class Register: CustomViewCOntroller {

    
    @IBOutlet var toolbarForKeyboard: UIToolbar!
    @IBOutlet var male: UIButton!
    @IBOutlet var female: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var iAgree: UIButton!
    @IBOutlet var contact: CustomTextView!
    @IBOutlet var radioF: UIButton!
    @IBOutlet var radioM: UIButton!
    @IBOutlet var cPassword: CustomTextView!
    @IBOutlet var password: CustomTextView!
    @IBOutlet var email: CustomTextView!
    @IBOutlet var lastName: CustomTextView!
    @IBOutlet var firstName: CustomTextView!
    
    //MARK:- Lifecycle Methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CscrollView = scrollView
        CtextField = contact
        contact.inputAccessoryView = toolbarForKeyboard
        setupKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.titleView?.tintColor = UIColor.white
    }

    //MARK:- Other Methodes
    
    @IBAction func keyboardHide(_ sender: Any) {
         self.view.endEditing(true)
    }
    @IBAction func radioF(_ sender: Any) {
        
            female.isSelected = true
            male.isSelected = false
    }
    @IBAction func radioM(_ sender: Any) {
        
            female.isSelected = false
            male.isSelected = true
    }
    
    @IBAction func Register(_ sender: Any) {
        
        if(firstName.isValidName() && lastName.isValidName() && email.isValidEmail() && password.isValidPassword() && cPassword.isValidPassword() && contact.isValidContact() && iAgree.isSelected)
        {
            if(password.text == cPassword.text)
            {
                let gen = (radioM.isSelected ? "Male" : "Female")
                
                let param = ["first_name" : firstName.text!,"last_name" : lastName.text! ,"email" : email.text!,"password" : password.text!,"confirm_password" : cPassword.text! ,"gender" : gen ,"phone_no" : contact.text!] as Dictionary
                SVProgressHUD.show()
                
                Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_User_REGISTER, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
                    response, responseUrl in
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
                    {
                        SVProgressHUD.showSuccess(withStatus: (responseUrl["message"] as! NSString) as String!)
                    }
                    else
                    {
                        SVProgressHUD.showError(withStatus: "Registration Failed")
                    }
                
                }, errorBlock: { error in
                        SVProgressHUD.showError(withStatus: "Registration Failed")
                
                })
            }
            else
            {
                cPassword.shake()
            }
        
        }
        
    }
    @IBAction func agreeButtonPressed(_ sender: Any) {
        if (sender as! UIButton).isSelected
        {
            (sender as! UIButton).isSelected = false
        }
        else{
            (sender as! UIButton).isSelected = true
        }
    }
    
}
