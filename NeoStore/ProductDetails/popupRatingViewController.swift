//
//  popupRatingViewController.swift
//  NeoStore
//
//  Created by webwerks1 on 7/5/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import Cosmos
class popupRatingViewController: UIViewController {
    @IBOutlet var titleName: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var ratingFront: NSLayoutConstraint!
    @IBOutlet var innerView: CustomView!
    @IBOutlet var rating: CosmosView!
    var productId = 0
    var ProductImage: UIImage? = nil
    var productName = ""
     // MARK:- Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = ProductImage
        titleName.text = productName
        self.view.subviews[0].backgroundColor = UIColor(colorLiteralRed: 0.66, green: 0.66, blue: 0.66, alpha: 0.3)
        showAnimate()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let val = (self.view.frame.width) / 7 - 3
        ratingFront.constant = val
        rating.settings.starSize = Double(val)
    }
    
     // MARK:- Other Methodes
    
    @IBAction func ratingNow(_ sender: Any) {
         ratingAction()
         removeAnimation()
    }
    
    @IBAction func tapOnInnerView(_ sender: Any) {
    }
    
    @IBOutlet var tapOnInnerView: UITapGestureRecognizer!
    @IBAction func tapAction(_ sender: Any) {
        removeAnimation()
    }
    
    /// Method to show animation for view presentation
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        })
    }
    
    /// Function to remove view from superview
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
    
    func ratingAction()
    {
        let ratingVal: String = "\(rating.rating)"
        let param = ["product_id":"\(productId)", "rating": ratingVal] as Dictionary<String, Any>
        
        SVProgressHUD.show()
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_PRODUCT_RATING, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print(responseUrl)
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
