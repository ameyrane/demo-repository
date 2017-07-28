//
//  AddAddress.swift
//  NeoStore
//
//  Created by webwerks1 on 6/28/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit

class AddAddress: CustomViewCOntroller, UITextViewDelegate {
    @IBOutlet var address: UITextView!
    @IBOutlet var landmark: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var zip: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var toolbarForKeyboard: UIToolbar!
    @IBOutlet var scrollView: UIScrollView!
    
    //MARK:- Lifecycle methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        zip.inputAccessoryView = toolbarForKeyboard
        CscrollView = scrollView
        CtextField = country
        address.delegate = self
        address.inputAccessoryView = toolbarForKeyboard
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        setupKeyboard()
    }
    
    //MARK:- UIDesign Methodes
    
    func setupNavigationBar()
    {
        self.navigationItem.title = "Add Address"
    }
     //MARK:- Other methodes
    
    @IBAction func saveAddress(_ sender: Any) {
        if addressValidations()
        {
        if let file = Bundle.main.path(forResource: "addressList", ofType: "plist")
        {
           let addresses = NSMutableArray(contentsOfFile: file)!
            let address : NSMutableDictionary = ["Address": self.address.text ,"City":self.city.text!,"Zip":self.zip.text!,"State":self.state.text!,"Country":self.country.text!,"Landmark":self.landmark.text!]
             addresses.add(address)
            addresses.write(toFile: file, atomically: true)
        }
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addressValidations() -> Bool
    {
        if landmark.isValidName() && city.isValidName() && state.isValidName() && zip.isValidNumber() && country.isValidName()
        {
            return true
        }
        
        return false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @IBAction func keyboardHide(_ sender: Any) {
        self.view.endEditing(true)
    }
  
}
