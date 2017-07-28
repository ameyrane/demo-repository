//
//  ProductsList.swift
//  NeoStore
//
//  Created by webwerks1 on 6/22/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import Cosmos
class ProductsList: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate
{
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var tblView: UITableView!
    var itemID: [Int] = []
    public enum ItemTypes: Int {
    case tables = 0
    case sofas = 1
    case chairs = 2
    case cupboards = 3
    }
    let itemsTypes = ["Tables", "Sofas","Chairs", "Cupboards"]
    var selectedItem: Int = ItemTypes.tables.rawValue
    
    var pData: [Dictionary<String,Any>] = []
    var productObjects: [Product] = []
    var productSearchList : [Product] = []
    var productData: Dictionary<String, Any>? = [:]
    //MARK:- Lifecycle Methodes
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigationBar()
        // setComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataList()
        print(selectedItem)
        searchController.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        searchController.dismiss(animated: true, completion: nil)
    }
    //MARK:- UIdesign Methodes
    
    func setupNavigationBar()
    {
        let image = UIImage(named: "search_icon")
        let item = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(search))
        
//        
//        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = "Product List"
        
    }
    
    func search()
    {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
  //MARK:- Tableview Methodes

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(pData.count)
        return productSearchList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedViewCOntroller = self.storyboard?.instantiateViewController(withIdentifier: "details") as! ProductDetails
        let dic = pData[indexPath.row]
        detailedViewCOntroller.productId = itemID[indexPath.row]
        //print(itemsTypes[selectedItem])
        detailedViewCOntroller.productType = "Category - \(itemsTypes[selectedItem])"
        detailedViewCOntroller.productName = (dic["name"]! as? String)!
        searchController.dismiss(animated: true, completion: nil)
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(detailedViewCOntroller, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! TableItemCell
//        let product = productObjects[indexPath.row]
//        let url = URL(string: product.productImages as! String)
//        
//                CommonClass.setImage(url! , successBlock: {
//                responseImage in
//                    cell.itemImage.image = responseImage
//                })

        ///**************///
        
        let product = productSearchList[indexPath.row]
        let url = URL(string: product.productImage )
        
        CommonClass.setImage(url! , successBlock: {
            responseImage in
            cell.itemImage.image = responseImage
        })
        
        cell.itemName.text = product.name!
        cell.itemDesc.text = product.des!
        cell.priceLbl.text = "Rs. \(product.cost!)"
        cell.itemRating.rating = Double(product.rating!)
        itemID.append(Int(product.id!)!)
        print(cell.productId)

        //********
        
//        let dic = pData[indexPath.row] 
//        
//        let url = URL(string: dic["product_images"] as! String)
//
//        CommonClass.setImage(url! , successBlock: {
//        responseImage in
//            cell.itemImage.image = responseImage
//        })
//
//        cell.itemName.text = dic["name"]! as? String
//        cell.itemDesc.text = dic["producer"]! as? String
//        cell.priceLbl.text = "Rs. \(dic["cost"]!)"
//        cell.itemRating.rating = dic["rating"] as! Double
//        itemID.append(dic["id"] as! Int)
//        print(cell.productId)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    //MARK:- Other Methodes
    
    func getDataList()
    {
        let param = ["product_category_id": "\(selectedItem + 1)"] as Dictionary<String, Any>
        SVProgressHUD.show()
//        Webservices.callGetMethod(ServiceName: WebservicesUrl.WS_PRODUCT_LIST, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
//        responseObj in
//            self.productObjects = Parser.responseStringParser(responseObj.responseString!, responseObj.response!, ClassTypes.ProductList) as! [Product]
//           
//        }, errorBlock: {error in
//                        let errorAction = UIAlertController(title: "Loading Failed", message: error as? String, preferredStyle: UIAlertControllerStyle.alert)
//                        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
//                        errorAction.addAction(action)
//                        self.present(errorAction, animated: true)
//            
//                        SVProgressHUD.dismiss()
//            
//                    })
        Webservices.callGetDataWithMethod(ServiceName: WebservicesUrl.WS_PRODUCT_LIST, param: param, headerValue: [:], isHud: true, hudView: self.view, successBlock: {
        response , responseUrl in
            self.productObjects = Parser.responseStringParser(responseUrl, response, ClassTypes.ProductList) as! [Product]
            self.productSearchList = self.productObjects
          // print(self.productObjects[1].cost!)
           if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
           {
           print(responseUrl)
           
           self.pData = responseUrl["data"] as! [Dictionary<String,Any>]
            
            self.tblView.reloadData()
           // print(self.pData[0])
            print(responseUrl)
            
            SVProgressHUD.dismiss()
            }
        }, errorBlock: {
            error in
            let errorAction = UIAlertController(title: "Loading Failed", message: error as? String, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            errorAction.addAction(action)
            self.present(errorAction, animated: true)
            
            SVProgressHUD.dismiss()

        })
    
    }
    
    
    //MARK:- search Bar related methodes
    func updateSearchResults(for searchController: UISearchController) {
       
        productSearchList = createSearchList(searchController.searchBar.text!)
        self.tableView.reloadData()
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
       
        productSearchList  = productObjects
        self.tableView.reloadData()
         searchController.dismiss(animated: true, completion: nil)
        self.tableView.tableHeaderView = nil
        
    }
   
    func createSearchList(_ text: String) -> [Product]
    {
        var searchList: [Product] = []
         for product in productObjects
         {
            if (product.name?.localizedStandardContains(text))! || (product.des?.localizedStandardContains(text))!
            {
                searchList.append(product)
            }
        }
        return searchList
    }
    
    

    
    
    //    func setComponents()
//    {
//        for view: UIView in self.view.subviews
//        {
//            print(view)
//            
//            if view is UITableView
//            {
//                for innerView: UIView in view.subviews
//                {
//                    if innerView is CosmosView
//                    {
//                        let cosmos = innerView as! CosmosView
//                        cosmos.settings.filledColor = UIColor(colorLiteralRed: 255, green: 186, blue: 0, alpha: 0)
//                        cosmos.settings.emptyColor = UIColor(colorLiteralRed: 127, green: 127, blue: 127, alpha: 0)
//                    }
//                    
//                }
//            }
//            
//            if view is CosmosView
//            {
//                let cosmos = view as! CosmosView
//                cosmos.settings.filledColor = UIColor(colorLiteralRed: 255, green: 186, blue: 0, alpha: 0)
//                cosmos.settings.emptyColor = UIColor(colorLiteralRed: 127, green: 127, blue: 127, alpha: 0)
//            }
//        }
//    }

    

  
}
