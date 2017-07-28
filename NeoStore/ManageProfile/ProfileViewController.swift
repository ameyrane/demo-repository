//
//  ProfileViewController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/30/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class ProfileViewController: CustomViewCOntroller {
    @IBOutlet var toolbarForKeyboard: UIToolbar!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var birthDate: CustomTextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var email: CustomTextView!
    @IBOutlet var sirName: CustomTextView!
    @IBOutlet var name: CustomTextView!
    @IBOutlet var contact: CustomTextView!
    
    // MARK:- Lifecycle methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contact.inputAccessoryView = toolbarForKeyboard
        birthDate.inputAccessoryView = toolbarForKeyboard
       
    }
    override func viewWillAppear(_ animated: Bool) {
        makeImageCircular()
        setupNavigationBar()
        setData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }

    // MARK:- UISetup methodes
    func setupNavigationBar()
    {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = "My Account"
        
    }
    func makeImageCircular()
    {
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    // MARK:- Other methodes
    @IBAction func keyboardHide(_ sender: Any) {
    }
    @IBAction func selectBirthDate(_ sender: CustomTextView) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let resetPassword = self.storyboard?.instantiateViewController(withIdentifier: "resetPassword") as! ResetPassword
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(resetPassword, animated: true)
    }
    
    @IBAction func editProfile(_ sender: Any) {
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "editProfile") as! EditProfile
            self.navigationItem.title = ""
        self.navigationController?.pushViewController(editProfile, animated: true)
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        birthDate.text = dateFormatter.string(from: sender.date)
    }
    
//    func getData()
//    {
//        let param = [:] as Dictionary<String, Any>
//        let userdefault = UserDefaults.standard
//        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
//        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
//        SVProgressHUD.show(withStatus: "message")
//        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_ACCOUNT_DETAILS, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
//            response, responseUrl in
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
//            {
//               // print(responseUrl)
//                self.setData(data: responseUrl["data"] as! Dictionary<String, Any>)
//                SVProgressHUD.showSuccess(withStatus: "message")
//            }
//            else
//            {
//                SVProgressHUD.showError(withStatus: responseUrl["message"] as! String)
//            }
//        }, errorBlock: {
//            error in
//            SVProgressHUD.showError(withStatus: "Error Message")
//        })
//    }
    
    // Fumction to set Values 
    func setData()
    {
       // let userData = data["user_data"] as! Dictionary<String, Any>
        let userData = CommonClass.getValuesFromUserDefaults(key: "logged_user") 
        name.text = userData["first_name"] as? String
        sirName.text = userData["last_name"] as? String
        contact.text = userData["phone_no"] as? String
        birthDate.text = userData["dob"] as? String
        email.text = userData["email"] as? String
    }

}
