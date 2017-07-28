//
//  MenuController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/21/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import LGSideMenuController
class MenuController: UITableViewController {

   // @IBOutlet var numberOfItemsInCart: UILabel!
    @IBOutlet var headerImage: UIImageView!
    @IBOutlet var tableHeader: UIView!
    @IBOutlet var emailOnHeader: UILabel!
    @IBOutlet var nameOnHeader: UILabel!
    var cartTotal: Int!
    var user: Dictionary<String, Any> = [:]
    let imageArray = ["shoppingcart_icon","tables_icon","chair_icon","sofa_icon","cupboard_icon","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    let nameArray = ["My Cart","Tables","Chairs","Sofas","Cupboards","My Account","Store Locator","My Orders","Logout"]
    
    
    //MARK:- Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        makeImageCircular()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = CommonClass.getValuesFromUserDefaults(key: "logged_user")
        nameOnHeader.text = "\(user["first_name"]!) \(user["last_name"]!)"
        emailOnHeader.text = "\(user["email"]!)"
        print(user)
    }
   
    func testData(){
        user = CommonClass.getValuesFromUserDefaults(key: "logged_user")
        print(user)
        self.tableView.reloadData()
    }

    //MARK:- UIDesign Related Methodes
    
    func makeImageCircular()
    {
        headerImage.layer.borderWidth = 2
        headerImage.layer.masksToBounds = false
        headerImage.layer.borderColor = UIColor.white.cgColor
        headerImage.layer.cornerRadius = headerImage.frame.height/2
        headerImage.clipsToBounds = true
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! LeftMenuTableCell
        
        
        cell.menuImage.image = UIImage(named: imageArray[indexPath.row])
        cell.menuName.text = nameArray[indexPath.row]
        cell.numberOfItemsInCart.isHidden = true
        
        cell.numberOfItemsInCart.text = user["total_carts"]! as? String
        if (nameArray[indexPath.row] == "My Cart")
        {
            cell.numberOfItemsInCart.isHidden = false
        }
     
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeftMenuTableCell
        print(cell.menuName.text!)
        
        print(indexPath.row)
        switch(indexPath.row)
        {
        case 0:
            let cart = self.storyboard?.instantiateViewController(withIdentifier: "mycart") as! MyCartViewController
            
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(cart, animated: true)
            self.hideLeftView(self)
            
            break;
        case 1:
            let itemsListController = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ProductsList
                        itemsListController.selectedItem = ProductsList.ItemTypes.tables.rawValue
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(itemsListController, animated: true)
            self.hideLeftView(self)
            break;
        case 2:
            let itemsListController = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ProductsList
            itemsListController.selectedItem = ProductsList.ItemTypes.sofas.rawValue
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(itemsListController, animated: true);
            self.hideLeftView(self)
            break;
            
        case 3:
            let itemsListController = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ProductsList
            itemsListController.selectedItem = ProductsList.ItemTypes.chairs.rawValue
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(itemsListController, animated: true);
            self.hideLeftView(self)
            break;
            
        case 4:
            let itemsListController = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ProductsList
            itemsListController.selectedItem = ProductsList.ItemTypes.cupboards.rawValue
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(itemsListController, animated: true)
            self.hideLeftView(self)
            break;
        case 5:
            let profile = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(profile, animated: true)
            self.hideLeftView(self)
            break;
        case 6:
            let storeLocator = self.storyboard?.instantiateViewController(withIdentifier: "storeLocator") as! StoreLocator
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(storeLocator, animated: true)
            self.hideLeftView(self)
            break;
        case 7:
            let orderList = self.storyboard?.instantiateViewController(withIdentifier: "orderList") as! OrderList
            let mainController = sideMenuController!.rootViewController as! UINavigationController
            mainController.pushViewController(orderList, animated: true)
            self.hideLeftView(self)

            break;
        case 8:
            let login = self.storyboard?.instantiateViewController(withIdentifier: "login")
            present(login!, animated: true, completion: nil)
            break;
        default:
            break;
        }
        
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
