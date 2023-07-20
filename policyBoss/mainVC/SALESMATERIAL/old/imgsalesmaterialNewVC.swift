//
//  imgsalesmaterialNewVC.swift
//  MagicFinmart
//
//  Created by iOS Developer on 20/05/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class imgsalesmaterialNewVC: UIViewController {
    
    
    var detailImg = ""
    var productID = ""
    
    var  empName = ""
    var  empEmail = ""
    var  empDesignation = ""
    var  empMobileNo = ""
    var  PhotoUrl  = ""
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    
    @IBOutlet weak var lblEmpName: UILabel!
    
    @IBOutlet weak var lblDesignation: UILabel!
    
    @IBOutlet weak var lblMobile: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailImg=",detailImg)
       let url = URL(string: detailImg)
        
        imgProduct.sd_setImage(with: url)
        

       
        
        if(productID == "4" ||  productID == "5" || productID == "6" || productID == "7" ){
            
            loanDetails()
        }else{
            pospDetails()
        }
        
        
     
                     
    }
    

    func validate(){
        
        if(empName.isEmpty){
            
            empName = "POSP Name"
        }
        if(empEmail.isEmpty){
            
            empEmail = "XXXXXX@finmart.com"
        }
        if(empMobileNo.isEmpty){
            
            empMobileNo = "98XXXXXXXX"
        }
        if(empDesignation.isEmpty){
            
            empDesignation = "LandMark POSP"
        }
        
        if(PhotoUrl.isEmpty){
            
            PhotoUrl =  "http://qa.mgfm.in/images/profile_pic.png"
        }
    }
    
    func pospDetails(){
        
        empName = UserDefaults.standard.string(forKey: "pospsendname") ?? "POSP Name"

        empEmail = UserDefaults.standard.string(forKey: "pospsendemail") ??  "XXXXXX@finmart.com"
        empMobileNo = UserDefaults.standard.string(forKey: "pospsendmobile") ?? "98XXXXXXXX"
        empDesignation = UserDefaults.standard.string(forKey: "pospsenddesignation") ??  "LandMark POSP"
        PhotoUrl = UserDefaults.standard.string(forKey: "pospsendphoto") ?? "http://qa.mgfm.in/images/profile_pic.png"
        
          print("PhotoUrl",PhotoUrl)
        
        validate()
        
        let url = URL(string: PhotoUrl)
        imgUser.sd_setImage(with: url)
        
       
       
        
        lblEmpName.text = empName
        lblDesignation.text = empDesignation
        lblMobile.text = empMobileNo
        lblEmail.text = empEmail
    }
    
    func loanDetails(){
        
        empName = UserDefaults.standard.string(forKey: "loansendname") ?? "POSP Name"
        empEmail = UserDefaults.standard.string(forKey: "loansendemail") ?? "XXXXXX@finmart.com"
        empMobileNo = UserDefaults.standard.string(forKey: "loansendmobile") ?? "98XXXXXXXX"
        empDesignation = UserDefaults.standard.string(forKey: "loansenddesignation") ?? "LandMark POSP"
        PhotoUrl = UserDefaults.standard.string(forKey: "loansendphoto") ?? "http://qa.mgfm.in/images/profile_pic.png"
         print("PhotoUrl",PhotoUrl)
        
        validate()
        
        let url = URL(string: PhotoUrl)
        imgUser.sd_setImage(with: url)
        
        
        lblEmpName.text = empName
        lblDesignation.text = empDesignation
        lblMobile.text = empMobileNo
        lblEmail.text = empEmail
        
    }
    
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        

    }
    
    @IBAction func ShareImageClick(_ sender: UIButton) {
        
      
           // imgUser.image = mainView.image()
            
//        
//             if(mainView.image() != nil){
//                
//                print("Image was created")
//                guard let  shareImage =  mainView.image() else{
//                    
//                    return
//                }
//                
//                let shareAll: [Any] = [ shareImage ]
//                
//                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = self.view
//                self.present(activityViewController, animated: true, completion: nil)
//            }else{
//                
//                print("Image was not created")
//                let shareAll: [Any] = [ empName,empDesignation,empMobileNo,empEmail , URL(string: detailImg)!]
//                
//                let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = self.view
//                self.present(activityViewController, animated: true, completion: nil)
//                
//            }
        
        
        
    }
    
    
   
    
//
//    @IBAction func ImageShareBtnClick(_ sender: Any) {
//
//
//
//
//      //  callAlertView()
//
//        print("Image was  created 000")
//
//                if(image(with: mainView) != nil){
//
//                    print("Image was created")
//                    guard let  shareImage =  image(with: mainView) else{
//
//                       return
//                    }
//
//                    imgUser.image = shareImage
//
////                    let shareAll: [Any] = [ shareImage ]
////
////                     let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
////                      activityViewController.popoverPresentationController?.sourceView = self.view
////                      self.present(activityViewController, animated: true, completion: nil)
//                }else{
//
//                       print("Image was not created")
////                    let shareAll: [Any] = [ empName,empDesignation,empMobileNo,empEmail , URL(string: detailImg)!]
////
////                    let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
////                    activityViewController.popoverPresentationController?.sourceView = self.view
////                    self.present(activityViewController, animated: true, completion: nil)
//
//                }
//    }
//
    
    
    
    @IBAction func homeBtnClick(_ sender: Any) {
        
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
          KYDrawer.modalPresentationStyle = .fullScreen
        self.present(KYDrawer, animated: true, completion: nil)
        
       
              
    }
    
    
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    
   
}


extension UIView {

    /// Creates an image from the view's contents, using its layer.
    ///
    /// - Returns: An image, or nil if an image couldn't be created.
    func image2() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        layer.render(in: context)
        context.restoreGState()
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

}
