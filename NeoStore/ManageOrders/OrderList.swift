//
//  OrderList.swift
//  NeoStore
//
//  Created by webwerks1 on 6/28/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class OrderList: UITableViewController {

    @IBOutlet var orderTable: UITableView!
    var orders: [Dictionary<String, Any>] = []
    
     //MARK:- Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

    }
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

  
     //MARK:-  UIdesign related Methodes
    func setupNavigationBar()
    {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.red
        self.navigationItem.title = "My Orders"
        
    }
    
    
     //MARK:-  Other Methodes
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
     //MARK:-  UITableview Methodes

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderCell
        let order = orders[indexPath.row]
        cell.orderID.text = "Order ID : \(String(describing: order["id"]!))"
        cell.orderDate.text = "Ordered Date : \(String(describing: order["created"]!))"
        cell.orderTotal.text = "₹\(String(describing: order["cost"]! as! Double))"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetails = self.storyboard?.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetails
        let order = orders[indexPath.row]
        orderDetails.orderId = "\(String(describing: order["id"]!))"
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(orderDetails, animated: true)
    }
    
    //MARK:- Function to access data from webservices
    func getData()
    {
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        print(user["access_token"]!)
        
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_ORDER_LIST, param: [:], headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response , responseUrl in
            //print(responseUrl["status"]!)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print(responseUrl)
                self.orders = responseUrl["data"] as! [Dictionary<String, Any>]
                self.orderTable.reloadData()
                SVProgressHUD.dismiss()
                
            }
            else
            {
                SVProgressHUD.dismiss()
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error")
            
        })
        
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

    
}
