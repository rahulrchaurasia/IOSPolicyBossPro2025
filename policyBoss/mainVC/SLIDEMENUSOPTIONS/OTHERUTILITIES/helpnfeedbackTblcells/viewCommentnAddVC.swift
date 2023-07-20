//
//  viewCommentnAddVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 08/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar

class viewCommentnAddVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var sscrollView: UIScrollView!
    @IBOutlet weak var myCommentView: UIView!
    @IBOutlet weak var myCommentViewHeight: NSLayoutConstraint!//420
    @IBOutlet weak var mycomntImgView: UIImageView!
    @IBOutlet weak var viewCommentTV: UIView!
    @IBOutlet weak var viewComntTVHeight: NSLayoutConstraint!//320
    @IBOutlet weak var viewCommentTVBottom: NSLayoutConstraint!
    @IBOutlet weak var cmntTf: ACFloatingTextfield!
    
    var commentListArray = [String]()
    var ticktreqId = ""
    var statusId = ""
    
    var fromScreen = ""
    var imagePicker = UIImagePickerController()
    var pickedImage = UIImage()
    var dataImage = ""

    var origBottomConstraintForPwd:CGFloat = 0
    var origBottomConstraintForPwd2:CGFloat = 0
    var needtoAdjustForKeyboard = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        let borderColor = UIColor.lightGray
        self.myCommentView.layer.cornerRadius=5.0;
        self.myCommentView.layer.borderWidth=1.0;
        self.myCommentView.layer.borderColor=borderColor.cgColor;
        
        if(fromScreen == "viewComment")
        {
            myCommentView.isHidden = true
            myCommentViewHeight.constant = 0
            viewCommentTV.isHidden = false
            viewComntTVHeight.constant = 320
//            viewCommentTVBottom.constant = 0
        }
        else if(fromScreen == "addComment")
        {
            myCommentView.isHidden = false
            myCommentViewHeight.constant = 420
            viewCommentTVBottom.constant = 0
            viewCommentTV.isHidden = true
//            viewComntTVHeight.constant = 0
        }

       
    }
    
  
    //----------<ScrollView move up with Keyboard>---------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: false)
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    //----------<ScrollView move up with Keyboard>---------
    
    
    //--<roundImageView>--
    override func viewDidLayoutSubviews()
    {
        mycomntImgView.layer.cornerRadius = mycomntImgView.frame.size.width/2
        mycomntImgView.layer.cornerRadius = mycomntImgView.frame.size.height/2
        mycomntImgView.clipsToBounds = true
    }
    
    
    @IBAction func backgrndBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func viewcmntCloseBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func cameraBtnCliked(_ sender: Any)
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - ImagePicker delegate
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        pickedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        print("pickedImage==",pickedImage)
        mycomntImgView.image = pickedImage
        //        myaccountImgeView.layer.cornerRadius = 64
        
        //--Encoding Base-64 image--
        let userImage:UIImage = pickedImage
        print("userImage",userImage)
        let imageData:NSData = userImage.pngData()! as NSData
        dataImage = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        
        self.view.layoutIfNeeded()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    //--<endCamera>--
    
    
    @IBAction func tableCloseBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func commentSubmitBtnCliked(_ sender: Any)
    {
        self.hideKeyboardWhenTappedAround()
        getticketrequestAPI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! viewCommentnAddTVCell
        
        cell.viewcomntImgView.layer.cornerRadius = mycomntImgView.frame.size.width/2
        cell.viewcomntImgView.clipsToBounds = true
        
        cell.viewcmntCellLbl.text! = commentListArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
    //--<APICALL>--
    func getticketrequestAPI()
    {
        if Connectivity.isConnectedToInternet()
        {
        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
        if let parentView = self.navigationController?.view
        {
            alertView.parentView = parentView
        }
        else
        {
            alertView.parentView = self.view
        }
        alertView.show()
        
        let params: [String: AnyObject] = ["comment": cmntTf.text! as AnyObject,
                                           "ticket_req_id": ticktreqId as AnyObject,
                                           "docpath":"" as AnyObject,
                                           "ticket_status_id": statusId as AnyObject]
        
        let url = "create-ticket-comments"
        
        FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
            alertView.close()
            
            self.view.layoutIfNeeded()
            
            let jsonData = userObject as? NSArray
            let Message = jsonData!.value(forKey: "Message") as AnyObject
            
            TTGSnackbar.init(message: "Comment Added Successfully.", duration: .long).show()
            
        }, onError: { errorData in
            alertView.close()
            let snackbar = TTGSnackbar.init(message: errorData.errorMessage, duration: .long)
            snackbar.show()
        }, onForceUpgrade: {errorData in})
        
        }else{
            let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
            snackbar.show()
        }
        
    }
    
    
}
