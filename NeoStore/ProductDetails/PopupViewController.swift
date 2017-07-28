//
//  PopupViewController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/29/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import Cosmos
class PopupViewController: UIViewController {

    @IBOutlet var titleOutlet: UILabel!
   
    @IBOutlet var toolbarForKeyboard: UIToolbar!
    @IBOutlet var ratingFront: NSLayoutConstraint!
    @IBOutlet var rating: CosmosView!
    @IBOutlet var ratingValue: UIView?
    @IBOutlet var ratingBackgroundView: UIView!
    @IBOutlet var orderBackgroundView: UIView!
    @IBOutlet var tapOrderPage: UITapGestureRecognizer!
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet var viewOutlet: UILabel!
    @IBOutlet var textFieldOutlet: UITextField!
    @IBOutlet var labelOutlet: UILabel!
    @IBOutlet var imageOutlet: UIImageView!
    var productId = 0
    var image: UIImage? = nil
    var productName = ""
    @IBOutlet var rateNowButton: CustomButton!
     // MARK:- Lifecycle Methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageOutlet.image = image
        titleOutlet.text = productName
        self.view.subviews[0].backgroundColor = UIColor(colorLiteralRed: 0.66, green: 0.66, blue: 0.66, alpha: 0.3)
        textFieldOutlet.inputAccessoryView = toolbarForKeyboard
        showAnimate()
    }
    
     // MARK:- Other Methodes
    @IBAction func DoneButtonAction(_ sender: Any) {
         self.view.endEditing(true)
    }
  
    @IBAction func tapOnCustomViewOrderPage(_ sender: Any) {
    }
    @IBAction func tapActionOnOrder(_ sender: Any) {
         removeAnimation()
    }
    
    @IBAction func tapAction(_ sender: Any) {
        removeAnimation()
    }
    
    @IBAction func tapOnCustomView(_ sender: Any) {
    }
  
    @IBAction func submitAction(_ sender: Any) {
        if textFieldOutlet.isvalidQuantity()
        {
        orderAcrion()
        removeAnimation()
        }
    }
    
    /// Function to Add view
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        })
    }
    
    /// Function to remove view from super view
    
    func removeAnimation()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
        }, completion: {
            (finish : Bool) in
            if(finish)
            {
                self.view.removeFromSuperview()
            }
            
        })
    }
    
    // function for set rating value to webservice
    
    func orderAcrion()
    {
        
        let param = ["product_id":"\(productId)", "quantity": textFieldOutlet.textWithoutWhiteSpaces()] as Dictionary<String, Any>
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_ADD_TO_CART, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print()
                let total = responseUrl["total_carts"]! as! Int
                
                 // accessing side menu controller object to change number of cart items on label
                let parentViewController = self.parent!
                let navinagtionControllerStack = (parentViewController.navigationController?.viewControllers)!
                let mainMenu = navinagtionControllerStack[0] as! MainScreenController
                let sideMenu = mainMenu.sideMenuController?.leftViewController as! MenuController
               // updating number of items into userdefaults
                CommonClass.editValuesInUserDefaults(value: "\(total)", keyForEdit: "total_carts", key: "logged_user")
                 sideMenu.testData()
                SVProgressHUD.showSuccess(withStatus: responseUrl["user_msg"] as! String)
            }
            else
            {
                SVProgressHUD.showError(withStatus: responseUrl["message"] as! String)
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Something went wrong, try again")
        })
        
    }


}
