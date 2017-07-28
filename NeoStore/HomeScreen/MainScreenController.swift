//
//  MainScreenController.swift
//  NeoStore
//
//  Created by webwerks1 on 6/21/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import LGSideMenuController
class MainScreenController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var viewWidth: NSLayoutConstraint!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var viewOutlet: UIView!
    @IBOutlet var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet weak var cellectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var scrollIndex = 0
     let cellImages = ["tableicon","chairsicon","sofaicon","cupboardicon"]
     let sliderImages = ["slider_img1", "slider_img2" ,"slider_img3" ,"slider_img2"]
    @IBAction func showLeftMenu(_ sender: Any) {
       
        AddSideBar()
    }
    //MARK:- Lifecycle Methodes
    override func viewWillAppear(_ animated: Bool) {
        setlayout()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        pageControl.numberOfPages = sliderImages.count
        pageControl.currentPage = 0
        imageScrollView.delegate = self
        self.navigationItem.backBarButtonItem?.title = ""
        
        addSliderImages()
        //sideMenuController?.leftViewController
        
    }

    
    //MARK:- UIDesign Methodes
    func addSliderImages()
    {
        var x: CGFloat = 0.0

        viewWidth.constant = (self.view.layer.frame.width * CGFloat(sliderImages.count))

       
        for i in 0..<sliderImages.count
        {
                let imageView = UIImageView()
                imageView.frame = CGRect(x: x, y: 0, width: self.view.layer.frame.width, height: imageScrollView.frame.height)
                imageView.image = UIImage(named: sliderImages[i])
                viewOutlet.addSubview(imageView)
                x += self.view.layer.frame.width
        }
        
    }
    
    func setlayout()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width  = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 15, left: 13, bottom: 0, right: 13)
        layout.itemSize = CGSize(width: (width / 2) - 20 , height: (width / 2) - 20)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        
        cellectionView.collectionViewLayout = layout

    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setlayout()
    }
    
    // MARK:- Collectionview Methodes
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MainMenuCell
        cell.imageOnCell.image = UIImage(named: cellImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let ItemsListController = self.storyboard?.instantiateViewController(withIdentifier: "list") as! ProductsList
        ItemsListController.selectedItem = indexPath.row
        //present(ItemsListController, animated: true, completion: nil)
        self.navigationController?.pushViewController(ItemsListController, animated: true)
        
    }
    
    // Scrollview methodes
    
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        scrollIndex = (Int)((scrollView.contentOffset.x ) / scrollView.frame.width)
        pageControl.currentPage = scrollIndex
    }
    
   
    
    // MARK:- Other Methodes

    
    /// Func to add Sidebar to Screen
    func AddSideBar()
    {
        sideMenuController?.leftViewWidth = self.view.frame.width - 30
        sideMenuController?.isRootViewStatusBarHidden = false
        sideMenuController?.leftViewBackgroundBlurEffect = UIBlurEffect(style: .regular)
        sideMenuController?.leftViewPresentationStyle = .scaleFromBig
        sideMenuController?.showLeftView(animated: false, completionHandler: nil)
        
    }
    
    
   
    
    

}
