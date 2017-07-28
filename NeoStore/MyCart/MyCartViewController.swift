//
//  MyCartViewController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/22/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource {
    
    @IBOutlet var totalCost: UILabel!
    @IBOutlet var viewForTotal: UIView!
    @IBOutlet var OuterView: UIView!
    @IBOutlet var listView: UITableView!
    let backView = UIView()
    @IBOutlet var orderNow: CustomButton!
    @IBOutlet var tableViewOutlet: UITableView!
    @IBOutlet var cellForFooter: UIView!
    var selectedCellIndex: IndexPath = []
    var dictionaries: [Dictionary<String,Any>] = []
    
    // MARK:- Lifecycle Methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.delegate = self
        tableViewOutlet.delegate = self
        listView.dataSource = self
        tableViewOutlet.dataSource = self
        viewForTotal.layer.borderWidth = 1
        viewForTotal.layer.borderColor = UIColor.lightGray.cgColor
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    
    // MARK:- Other Methodes

    @IBAction func PlaceOrder(_ sender: Any) {
        let addressController = self.storyboard?.instantiateViewController(withIdentifier: "address") as! ManageAddress
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(addressController, animated: true)
    }
    
    @IBAction func dropDAction(_ sender: Any) {
        let button = (sender as! UIButton)
        print(button.tag)
        let c = button.convert(button.bounds, to: self.view)
        print(c)
        print(c.minY)
        let cell = (sender as! UIButton).convert(CGPoint.zero, to: self.tableViewOutlet)
        selectedCellIndex = tableViewOutlet.indexPathForRow(at: cell)!
        print(selectedCellIndex.row)
        let width = button.frame.width
        let height = button.frame.height

        backView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnBackView))
        tap.delegate = self
        backView.addGestureRecognizer(tap)
       
        self.view.addSubview((backView))
        self.view.addSubview(listView!)
         self.listView.frame = CGRect(x: c.minX, y: (c.minY + height ) , width: width, height: 0)
        UIView.animate(withDuration: 0.5, animations: {
         self.listView.frame = CGRect(x: c.minX, y: (c.minY + height ) , width: width, height: 150)
        }
            , completion: nil)
    }
    
    func tapOnBackView()
    {
        listView.removeFromSuperview()
        backView.removeFromSuperview()
    }
    
    @IBAction func tapAction(_ sender: Any) {
        listView.removeFromSuperview()
    }
   
    //MARK:- UIDesign Methodes
    
    func setupNavigationBar()
    {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = "My Cart"
        
    }
    
   
    //MARK:- Tableview Realted Methodes
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listView
        {
            return 8
        }
        else
        {
        
        return (dictionaries.count)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "quantityNumber") as! QuantityNumberCell
            cell.quantityNumber.text = (indexPath.row + 1).description
            
            return cell
        }
        else
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItem", for: indexPath) as! ItemListCell
            cell.buttonDropDown.tag = indexPath.row
            let dic = dictionaries[indexPath.row]
            let quantity = dic["quantity"]!
            print("quantities \(quantity)")
            cell.buttonDropDown.setTitle("\(quantity)  v", for: .normal)
            let productDetails = dic["product"] as! Dictionary<String, Any>
            cell.itemName.text = productDetails["name"] as? String
            cell.itemDescription.text = "(\(String(describing: productDetails["product_category"]! as! String)))"
            cell.priceLabel.text = "₹ \(String(describing: productDetails["cost"]!))"
            let url = URL(string: productDetails["product_images"] as! String)
            CommonClass.setImage(url! , successBlock: {
                responseImage in
                cell.itemImage.image = responseImage
            })
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       if tableView == listView
       {
         return nil
        }
        else
       {
        cellForFooter.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 104)
        cellForFooter.backgroundColor = UIColor.blue
        return cellForFooter
        }
    }
  
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == listView
        {
            return 0
        }
        else
        {
            return 164
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listView
        {
            return 20
        }
        else
        {
        return 103
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if tableView == listView
        {
            let dic = dictionaries[selectedCellIndex.row]
            let productId = dic["product_id"]
            editQuantity(productId as! Int, indexPath.row)
            listView.removeFromSuperview()
            backView.removeFromSuperview()
            let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cartItem", for: selectedCellIndex) as! ItemListCell
            cell.buttonDropDown.setTitle("\(indexPath.row)", for: .normal)

        }
        else
        {
            print(indexPath)
            
        }
    }
    
    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        if tableView == listView
//        {
//            //            let cell = tableView.dequeueReusableCell(withIdentifier: "quantityNumber", for: indexPath) as! QuantityNumberCell
//            print(indexPath.row)
//            listView.removeFromSuperview()
//            backView.removeFromSuperview()
//        }
//        else
//        {
//            print(indexPath)
//            
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == listView
        {
            return []
        }
        else
        {
        let action = UITableViewRowAction(style: .default, title: "", handler: {(action, indexPath) in
            tableView.isEditing = true
            let dic = self.dictionaries[indexPath.row]
            let productId = dic["product_id"]
            self.deleteFromCart(productId as! Int)
        }
        )
       action.title = "          "
            
            let image = UIImage(named: "delete")
            
            action.backgroundColor = UIColor(patternImage: image!)
                return [action]
        }
    }
    
    // MARK:- DATA Accessing Method
    func getData()
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        print(user["access_token"]!)
       
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_CART_ITEMS, param: [:], headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print(responseUrl)
                if responseUrl["total"] as AnyObject is NSNull
                {
                    self.totalCost.text = "₹ 0.0"
                    self.orderNow.isUserInteractionEnabled = false
                    self.dictionaries = []
                }
                else
                {
                self.totalCost.text = "₹ \(responseUrl["total"]!)"
                self.dictionaries = responseUrl["data"] as! [Dictionary<String, Any>]
                //print("data is  = ****\(responseUrl["data"]!) ****\(self.dictionaries.count) ")
                
                self.orderNow.isUserInteractionEnabled = true
                }
                self.tableViewOutlet.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else
            {
                SVProgressHUD.showError(withStatus: "Something went wrong, try again")
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Something went wrong, try again")
            
        })
        
    }
    
    func editQuantity(_ productId: Int, _ quantity: Int)
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        print(user["access_token"]!)
        let param = ["product_id":"\(productId)","quantity":"\(quantity + 1)"] as Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show(withStatus: "message")
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_EDIT_CART, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                self.getData()
                self.tableViewOutlet.reloadData()
                
                SVProgressHUD.showSuccess(withStatus: "Done")
            }
            else
            {
                SVProgressHUD.showError(withStatus: "Error message1")
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error message")
            
        })

    }
    
    func deleteFromCart(_ productId: Int)
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
       
        let param = ["product_id":"\(productId)"] as Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show(withStatus: "message")
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_BDELETE_CART, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                self.getData()
                self.tableViewOutlet.reloadData()
                SVProgressHUD.showSuccess(withStatus: "Done")
                // accessing side menu controller object to change number of cart items on label
                // deleting from userdefaults
                let total = responseUrl["total_carts"]! as! Int
                
                // accessing side menu controller object to change number of cart items on label
                
                let navinagtionControllerStack = (self.navigationController?.viewControllers)!
                let mainMenu = navinagtionControllerStack[0] as! MainScreenController
                let sideMenu = mainMenu.sideMenuController?.leftViewController as! MenuController
                // updating number of items into userdefaults
                CommonClass.editValuesInUserDefaults(value: "\(total)", keyForEdit: "total_carts", key: "logged_user")
                sideMenu.testData()

            }
            else
            {
                SVProgressHUD.showError(withStatus: "Error message1")
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error message")
            
        })

    }
    
    

    
    
   
}
