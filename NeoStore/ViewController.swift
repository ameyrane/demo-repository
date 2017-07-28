//
//  ViewController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/20/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class ViewController: CustomViewCOntroller {
    
    var code = 0
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var password: CustomTextView!
    @IBOutlet var username: CustomTextView!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet var forgotPassword: UILabel!
    
     //MARK:- ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        CscrollView?.delegate = self
        CscrollView = scrollView
        CtextField = username
       
        setupKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = ""
    }
    
    //MARK:- Other Functions

    @IBAction func loginAction(_ sender: Any) {
        //         loginRequest()
        if (username.isValidEmail() && password.isValidPassword())
        {
            let param = ["email": username.textWithoutWhiteSpaces() , "password": password.textWithoutWhiteSpaces()] as Dictionary<String, Any>
           
            SVProgressHUD.show()
            Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_USER_LOGIN, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
                {

                    let userData: Dictionary<String, Any> = responseUrl;
                
                    print(userData["data"]!)
                    CommonClass.updateUserDetails(accessToken: (userData["data"] as! Dictionary<String, Any>)["access_token"] as! String, view: self.view)
                 
                        let menuController = self.storyboard?.instantiateViewController(withIdentifier: "menu")
                        self.present(menuController!, animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                }
                
            }, errorBlock: {
                error in
                let errorAction = UIAlertController(title: "Login Failed", message: "Email or password is wrong. try again", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                errorAction.addAction(action)
                self.present(errorAction, animated: true)
                

                SVProgressHUD.dismiss()
            })
        }else{
                    SVProgressHUD.dismiss()
            }
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        let param = ["email": username.textWithoutWhiteSpaces()] as Dictionary<String, Any>
        
        SVProgressHUD.show()
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_FORGOT_PASSWORD, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
               
                SVProgressHUD.showSuccess(withStatus: responseUrl["user_msg"] as! String)
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
    
    @IBAction func addAccount(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let createAccount = self.storyboard?.instantiateViewController(withIdentifier: "Register") as! Register
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(createAccount, animated: true)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getData(accessToken: String)
    {
        
    }
    
}

