//
//  OrderDetails.swift
//  NeoStore
//
//  Created by webwerks1 on 6/29/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class OrderDetails: UITableViewController {

    @IBOutlet var orderTable: UITableView!
    @IBOutlet var footerView: UIView!
    var orderId: String = ""
    @IBOutlet var totalCost: UILabel!
    var order: Dictionary<String, Any> = [:]
    var itemList: [Dictionary<String, Any>] = []
    //MARK:- Lifecycle Methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getData()
        setupNavigationBar()
    }
    
    //MARK:- UIDesign Methodes
    func setupNavigationBar()
    {
    
        self.navigationItem.backBarButtonItem?.title = ""
        
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        
        self.navigationItem.title = "Order ID: \(orderId)"
       
    }


    //MARK:- Function to access data from webservices
    func getData()
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        print(user["access_token"]!)
        let param = ["order_id": orderId]
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_ORDER_Details, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                //print(responseUrl)
                //let orderDetail = (responseUrl["data"] as! [Dictionary<String, Any>])
                self.order = responseUrl["data"] as! Dictionary<String, Any>
                self.totalCost.text = "₹\(String(describing: self.order["cost"]!))"
                self.itemList = self.order["order_details"] as! [Dictionary<String, Any>]
                self.orderTable.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else
            {
                SVProgressHUD.showError(withStatus: "Eoor")
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error")
            
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderItem", for: indexPath) as! OrderItem
        let item = itemList[indexPath.row]
        cell.itemName.text = "\(item["prod_name"]! )"
        cell.itemCost.text = "₹\(item["total"]! as! Double)"
        cell.itemQuantity.text = "QTY : \(item["quantity"]!)"
        cell.itemCategory.text = "(\(item["prod_cat_name"]!))"
        let url = URL(string: item["prod_image"] as! String)
        CommonClass.setImage(url! , successBlock: {
            responseImage in
            cell.itemImage.image = responseImage
        })


        return cell
    }
 
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 76
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
