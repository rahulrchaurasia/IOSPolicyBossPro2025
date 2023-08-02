//
//  ShareImageVC.swift
//  MagicFinmart
//
//  Created by Umesh MacBook on 11/6/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit

class ShareImageVC: UIViewController {
    
    var detailImg = ""
    var productID = ""
    
    var  empName = ""
    var  empEmail = ""
    var  empDesignation = ""
    var  empMobileNo = ""
    var  PhotoUrl  = ""
    
   
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var imgProduct: UIImageView!
    
    @IBOutlet var imgUser: UIImageView!
    
    @IBOutlet var lblEmpName: UILabel!
    
    @IBOutlet var lblDesignation: UILabel!
    
    @IBOutlet var lblMobile: UILabel!
    
    @IBOutlet var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.SalesShareScreen)

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
    
    @IBAction func homeBtnClick(_ sender: Any) {
        

        
        self.dismissAll(animated: false)
    }
    
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)

    }
    
    
    @IBAction func shareImageBtnClick(_ sender: Any) {
    
        
         if(mainView.image() != nil){

            print("Image was created")
            guard let  shareImage =  mainView.image() else{

                return
            }

            let shareAll: [Any] = [ shareImage ]

            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }else{

            print("Image was not created")
            let shareAll: [Any] = [ empName,empDesignation,empMobileNo,empEmail , URL(string: detailImg)!]

            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)

        }
    }
}



extension UIView {

    /// Creates an image from the view's contents, using its layer.
    ///
    /// - Returns: An image, or nil if an image couldn't be created.
    func image() -> UIImage? {
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

