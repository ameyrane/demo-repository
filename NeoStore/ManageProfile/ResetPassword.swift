//
//  ResetPassword.swift
//  NeoStore
//
//  Created by webwerks1 on 6/30/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class ResetPassword: CustomViewCOntroller {
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var oldPassword: CustomTextView!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
     //MARK:-  Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        CscrollView = scrollView
        CtextField = confirmPassword
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    //MARK:-  UIdesign related Methodes
    func setupNavigationBar()
    {
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = "Reset Password"
    }
    
     //MARK:-  Other Methodes
    @IBAction func resetPassword(_ sender: Any)
    {
        if(oldPassword.isValidPassword() && newPassword.isValidPassword() && confirmPassword.isValidPassword())
        {
            if (newPassword.text != confirmPassword.text)
            {
                confirmPassword.shake()
            }
            else{
            resetPassword()
            }
        }
    }
    
    // Function for reseting password
    func resetPassword()
    {
        let param = ["old_password": oldPassword.textWithoutWhiteSpaces() , "password": newPassword.textWithoutWhiteSpaces(),"confirm_password": confirmPassword.textWithoutWhiteSpaces()] as Dictionary<String, Any>
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show(withStatus: "message")
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_USER_CHANGE_PASSWORD, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                self.navigationController?.popViewController(animated: true)
                SVProgressHUD.showSuccess(withStatus: responseUrl["message"] as! String)
            }
            else
            {
                SVProgressHUD.showError(withStatus: responseUrl["message"] as! String)
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error Message")
        })
    }
   
}
