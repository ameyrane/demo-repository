//
//  ProductDetails.swift
//  NeoStore
//
//  Created by webwerks1 on 6/22/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import Cosmos
class ProductDetails: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
     var productId = 0
     var productType = ""
    var selectedImage = 0
    var productName = ""
    // MARK:- Outlets
    @IBOutlet var outOfStock: UILabel!
    @IBOutlet var itemRating: CosmosView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    
    @IBOutlet var itemDescription: UILabel!
    @IBOutlet var superCollectionView: CustomView!

    @IBOutlet var mainView: UIView!
    @IBOutlet var popoverView: UIView!
   
    @IBOutlet var smallCollectionHeight: NSLayoutConstraint!
    @IBOutlet var largeImageCollectionView: UICollectionView!
    
    @IBOutlet var largeVIewConstant: NSLayoutConstraint!
    @IBOutlet var smallCollectionView: UICollectionView!
    
    var imageDictionaries: [Dictionary<String, Any>] = []
    // MARK:- Lifecycle methodes
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeImageCollectionView.delegate = self
        largeImageCollectionView.dataSource = self
        getData()
        setlayout()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK:- UIdesign methodes
    func setupNavigationBar()
    {
        self.navigationItem.backBarButtonItem?.title = ""
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = productName
        //        let bounds = self.navigationController!.navigationBar.bounds
        //        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height)
    }

    /// Function to set color to cosmos view
    func setComponents()
    {
        for view: UIView in self.view.subviews
        {
            if view is CosmosView
            {
                let cosmos = view as! CosmosView
                cosmos.settings.filledColor = UIColor(colorLiteralRed: 255, green: 186, blue: 0, alpha: 0)
                cosmos.settings.emptyColor = UIColor(colorLiteralRed: 127, green: 127, blue: 127, alpha: 0)
            }
        }
    }
    
    /// Func to Layout of Screen
    
    func setlayout()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        largeVIewConstant.constant = largeImageCollectionView.frame.width - 100
        let width  = largeImageCollectionView.frame.width
        let height  = largeImageCollectionView.frame.height
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width , height: height - 40 )
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        smallCollectionHeight.constant = largeVIewConstant.constant / 2 - 15
        
        largeImageCollectionView.collectionViewLayout = layout
        smallCollectionViewLayout()
    }
    func smallCollectionViewLayout()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width  = smallCollectionView.frame.width
        let height = smallCollectionView.frame.height
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width / 3) - 10 , height: (height / 2) + 5)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 2
        
        smallCollectionView.collectionViewLayout = layout
        
    }
    
    //MARK:- Collection View methodes
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == largeImageCollectionView
        {
            return 1
        }
        else
        {
            return imageDictionaries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == largeImageCollectionView
        {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "large", for: indexPath) as! ProductImageCell
            if imageDictionaries.count > 0
            {
                let dic = imageDictionaries[selectedImage]
                let url = URL(string: dic["image"] as! String)
                
                CommonClass.setImage(url! , successBlock: {
                    responseImage in
                    cell.productImage.image = responseImage
                })

            }
            return cell
        }
        else
        {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "small", for: indexPath) as! SmallCollectionCell
            if imageDictionaries.count > 0
            {
                let dic = imageDictionaries[indexPath.row]
                let url = URL(string: dic["image"] as! String)
                CommonClass.setImage(url! , successBlock: {
                    responseImage in
                    cell.imageOutlet.image = responseImage
                })

            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == largeImageCollectionView
        {
            
        }
        else
        {
            selectedImage = indexPath.row
            largeImageCollectionView.reloadData()
        }
    }
    
     
     // MARK:- Other Methodes
    
    @IBAction func shareButtonAction(_ sender: Any) {
     
        let text = titleLabel.text!
        

        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
     
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func rateAction(_ sender: Any) {
        let childViewController = self.storyboard?.instantiateViewController(withIdentifier: "popupRating") as! popupRatingViewController
        let dic = imageDictionaries[0]
        let url = URL(string: dic["image"] as! String)
        let data = try? Data(contentsOf: url!)
        childViewController.ProductImage = UIImage(data: data!)
        childViewController.productName = productName
        childViewController.productId = self.productId
        childViewController.view.layer.cornerRadius = 20
        self.addChildViewController(childViewController)
        childViewController.view.frame =  self.view.frame
        self.view.addSubview((childViewController.view)!)
       //childViewController.didMove(toParentViewController: self)
        //childViewController.view.contentHuggingPriority(for: .vertical)
    }
   
    @IBAction func buyAction(_ sender: Any) {
       let childViewController = self.storyboard?.instantiateViewController(withIdentifier: "popupQuantity") as! PopupViewController
        let dic = imageDictionaries[0]
        let url = URL(string: dic["image"] as! String)
        let data = try? Data(contentsOf: url!)
        childViewController.productName = productName
        childViewController.image = UIImage(data: data!)
        childViewController.productId = self.productId
        childViewController.view.layer.cornerRadius = 20
        self.addChildViewController(childViewController)
        childViewController.view.frame =  self.view.frame
        self.view.addSubview((childViewController.view)!)
        //childViewController.didMove(toParentViewController: self)
        //childViewController.view.contentHuggingPriority(for: .vertical)
    }
    
    // MARK:- DATA Accessing Method
    func getData()
    {
        let param = ["product_id": "\(productId)"] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_PRODUCT_DETAILS, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
           //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                
                print(responseUrl)
                self.setData(data: responseUrl["data"] as! Dictionary<String, Any>)
                SVProgressHUD.dismiss()
            }
            else
            {
                let errorAction = UIAlertController(title: "Error", message: "Error in Fetching Details", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                errorAction.addAction(action)
                self.present(errorAction, animated: true)
                
                
                SVProgressHUD.dismiss()

            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error")
            
        })
        
    }
    
    // Function for setting data to screen
    func setData(data:Dictionary<String,Any>)
    {
        category.text = productType
        costLabel.text = "Rs. \(String(describing: (data["cost"]! as! Int)))"
        titleLabel.text = data["name"] as? String
        itemRating.rating = (data["rating"] as? Double)!
        subTitleLabel.text = data["producer"] as? String
        itemDescription.text = data["description"] as? String
        imageDictionaries = data["product_images"] as! [Dictionary<String,Any>]
        smallCollectionView.reloadData()
        largeImageCollectionView.reloadData()
        
    }

}
