//
//  ManageAddress.swift
//  NeoStore
//
//  Created by webwerks1 on 6/27/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class ManageAddress: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var selectedAddress: Int? = nil
    var radioButtonGroup: [Int: UIButton] = [:]
    @IBOutlet var tableView: UITableView!
    @IBOutlet var footerButtonView: UIView!
    
    var addresses: NSArray = []
    
    // MARK:- Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //radioButtonGroup = []
        setupNavigationBar()
        loadPlist()
        tableView.reloadData()
        selectedAddress = nil
    }
    
    //MARK:- Other Methodes
        @IBAction func deleteAddress(_ sender: Any) {
    
        if let file = Bundle.main.path(forResource: "addressList", ofType: "plist")
        {
             self.tableView.beginUpdates()
            let touchButton = (sender as! UIButton).convert(CGPoint.zero, to: self.tableView)
            print(touchButton)
            let cellIndex = tableView.indexPathForRow(at: touchButton)
            
            print(cellIndex!)
            
            let addresses = NSMutableArray(contentsOfFile: file)!
            addresses.removeObject(at: (cellIndex?.row)!)
            addresses.write(toFile: file, atomically: true)
           
             if (radioButtonGroup[(cellIndex?.row)!])?.isSelected == true
             {
                selectedAddress = nil
             }
            radioButtonGroup.removeValue(forKey: (cellIndex?.row)!)
            tableView.deleteRows(at: [cellIndex!], with: UITableViewRowAnimation.left)
            loadPlist()
            self.tableView.endUpdates()
            //tableView.reloadData()
            //tableView.reloadSections([0], with: UITableViewRowAnimation.fade)
        }
    }
  
    @IBAction func selectAddress(_ sender: Any) {
        deselectRadioButtons()
        (sender as! UIButton).isSelected = true
        let touchButton = (sender as! UIButton).convert(CGPoint.zero, to: self.tableView)
        let cellIndex = tableView.indexPathForRow(at: touchButton)
        selectedAddress = cellIndex?.row
    }
    @IBAction func placeOrder(_ sender: Any) {
        if selectedAddress != nil
        {
            placeMyOrder()
        }
    }
    
    func deselectRadioButtons()
    {
        for  button: UIButton in radioButtonGroup.values
        {
            button.isSelected = false
        }
    }
    
    func loadPlist()
    {
        if let file = Bundle.main.path(forResource: "addressList", ofType: "plist")
        {
            addresses =  NSArray(contentsOfFile: file)!
        }
    }
    
    func setupNavigationBar()
    {
        let item = UIBarButtonItem(image: UIImage(named: "add-1"), style: .plain, target: self, action: #selector(addAddress))
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.title = "Address List"
        item.tintColor = UIColor.white
    }
    func addAddress()
    {
        let addAddressController = self.storyboard?.instantiateViewController(withIdentifier: "addAddress")
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(addAddressController!, animated: true)
    }
    
    // function to place order using webservice
    func placeMyOrder()
    {
        let address = addresses[selectedAddress!] as! Dictionary<String, Any>
        let fullAddrss = "\(String(describing: address["Address"])), \(String(describing: address["Landmark"])), \(String(describing: address["City"])), \(String(describing: address["State"])), \(String(describing: address["Country"])), \(String(describing: address["Zip"]))"
         let param = ["address" : fullAddrss]
        
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as  Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_ORDER, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print(responseUrl)
             
                // deleting from userdefaults
                // accessing side menu controller object to change number of cart items on label
                
                let navinagtionControllerStack = (self.navigationController?.viewControllers)!
                let mainMenu = navinagtionControllerStack[0] as! MainScreenController
                let sideMenu = mainMenu.sideMenuController?.leftViewController as! MenuController
                // updating number of items into userdefaults
                CommonClass.editValuesInUserDefaults(value: "\(0)", keyForEdit: "total_carts", key: "logged_user")
                sideMenu.testData()
                
                SVProgressHUD.showSuccess(withStatus: responseUrl["user_msg"] as! String)
                
                self.navigationController?.popToRootViewController(animated: true)

            }
            else
            {
                let errorAction = UIAlertController(title: "Failed", message: responseUrl["user_msg"] as? String, preferredStyle: UIAlertControllerStyle.alert)
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
    
    // MARK:- Tableview Methodes
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (addresses.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! AddressCell
      
        let address: NSDictionary = addresses[indexPath.row] as! NSDictionary
        cell.heading.text = "User"
        cell.addressDetails.text = address.value(forKey: "Address")! as? String
        cell.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        if indexPath.row == 0
        {
            cell.radioButton.isSelected = true
            selectedAddress = 0
        }
        else
        {
            cell.radioButton.isSelected = false
        }
        //radioButtonGroup.insert(contentsOf: [cell.radioButton], at: indexPath.row)
        
        radioButtonGroup[indexPath.row] = cell.radioButton
        //radioButtonGroup.append(cell.radioButton)
              return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        deselectRadioButtons()
        print(indexPath.row)
        print(radioButtonGroup.count)
       // radioButtonGroup[indexPath.row].isSelected = true
        (radioButtonGroup[indexPath.row])?.isSelected = true
        selectedAddress = indexPath.row
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
              return footerButtonView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 118
    }
    
    

}
