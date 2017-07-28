//
//  EditProfile.swift
//  NeoStore
//
//  Created by webwerks1 on 6/30/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}
extension UIImage {
    
    public func base64(format: ImageFormat) -> String {
        var imageData: NSData
        switch format {
        case .PNG: imageData = UIImagePNGRepresentation(self)! as NSData
        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)! as NSData
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}
class EditProfile: CustomViewCOntroller, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var toolbarForKeyboard: UIToolbar!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var birthDate: CustomTextView!
    @IBOutlet var phone: CustomTextView!
    @IBOutlet var email: CustomTextView!
    @IBOutlet var sirName: CustomTextView!
    @IBOutlet var name: CustomTextView!
    @IBOutlet var profileImage: UIImageView!
    var profileImageUrl = ""
    // MARK:- Lifecycle methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        CtextField = phone
        CscrollView = scrollView
        phone.inputAccessoryView = toolbarForKeyboard
        birthDate.inputAccessoryView = toolbarForKeyboard
        setupKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        makeImageCircular()
        setupNavigationBar()
    }
    
    //MARK:-  UIdesign related Methodes
    func setupNavigationBar()
    {
        let item = UIBarButtonItem()
        item.image = UIImage(named: "search_icon")
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.titleView?.tintColor = UIColor.white
        self.navigationItem.title = "My Account"
        
    }
    func makeImageCircular()
    {
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    // MARK:- Image Picker Methodes 
     // tap action to open imgage picker
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let url = info["UIImagePickerControllerReferenceURL"]
        print(info[UIImagePickerControllerMediaType]!)
        profileImageUrl = String(describing: url)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //MARK:-  Other Methodes
    @IBAction func keyboardHide(_ sender: Any) {
         self.view.endEditing(true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
       if(name.isValidName() && sirName.isValidName() && email.isValidEmail() && phone.isValidContact() && birthDate.isNotEmpty())
       {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/yyyy"
        let showDate = inputFormatter.date(from: birthDate.textWithoutWhiteSpaces())
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
//        
//        let imageData:NSData = UIImagePNGRepresentation(profileImage.image!)! as NSData
//        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
     
        
        let param = ["first_name": name.textWithoutWhiteSpaces(),"last_name" : sirName.textWithoutWhiteSpaces() ,"email": email.textWithoutWhiteSpaces(),"dob": resultString,"phone_no": phone.textWithoutWhiteSpaces(), "profile_pic" : ""] as Dictionary<String, Any>
        let userdefault = UserDefaults.standard
        let user = userdefault.object(forKey: "logged_user") as! Dictionary<String, Any>
        let header = ["access_token":user["access_token"]!] as Dictionary<String, Any>
        SVProgressHUD.show()
        Webservices.callPOSTServiceMethod(ServiceName: WebservicesUrl.WS_UPDATE_ACCOUNT, param: param, headerValue: header, isHud: true, hudView: self.view, successBlock: {
            response, responseUrl in
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200
            {
                print(responseUrl)
                
                CommonClass.updateUserDetails(accessToken: user["access_token"]! as! String, view: self.view)
               
                SVProgressHUD.showSuccess(withStatus: responseUrl["user_msg"] as! String)
                
             
            }
            else
            {
                SVProgressHUD.showError(withStatus: responseUrl["message"] as! String)
            }
        }, errorBlock: {
            error in
            SVProgressHUD.showError(withStatus: "Error")
        })

        }
    }
    
    
    @IBAction func birthdatePicker(_ sender: CustomTextView) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    
      
    }
    
//    func addDoneButton()
//    {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0,y: 0,width: 320,height: 50))
//        doneToolbar.barStyle = UIBarStyle.default
//        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(keyboardWillHide))
//        
//        var items = [UIBarButtonItem]()
//        items.append(flexSpace)
//        items.append(done)
//        
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        
//        self.phone.inputAccessoryView = doneToolbar
//        
//    }
    
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        birthDate.text = dateFormatter.string(from: sender.date)
        //addDoneButton(txtField: birthDate)
        
    }
    
    
    
    
    

   

}
