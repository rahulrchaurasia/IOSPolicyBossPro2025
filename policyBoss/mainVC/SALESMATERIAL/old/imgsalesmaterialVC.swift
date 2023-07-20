//
//  imgsalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Admin on 23/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit
import SDWebImage
import CustomIOSAlertView


///******************************///

   // NOT IN USED

// Insted use imgsalesmaterialVCNew
///******************************///

class imgsalesmaterialVC: UIViewController,UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var detailImgView: UIImageView!
    
    var detailImg = ""
    var productID = ""
    
   var  empName = ""
   var  empEmail = ""
   var  empDesignation = ""
   var  empMobileNo = ""
   var  PhotoUrl  = ""
     var newline  = "\n\n"
    
     // NOT IN USED   //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("detailImg=",detailImg)
        let url = URL(string: detailImg)
        
//        let data = try? Data(contentsOf: url!)
//        detailImgView.image = UIImage(data: data!)
        
         detailImgView.sd_setImage(with: url)
        
        if(productID == "4" ||  productID == "5" || productID == "6" || productID == "7" ){
            
             loanDetails()
        }else{
               pospDetails()
        }
       
      
        
    }
    
    func pospDetails(){
        
          empName = UserDefaults.standard.string(forKey: "pospsendname") ?? "POSP Name"
          empEmail = UserDefaults.standard.string(forKey: "pospsendemail") ?? "XXXXXX@finmart.com"
          empMobileNo = UserDefaults.standard.string(forKey: "pospsendmobile") ?? "98XXXXXXXX"
          empDesignation = UserDefaults.standard.string(forKey: "pospsenddesignation") ?? "LandMark POSP"
          PhotoUrl = UserDefaults.standard.string(forKey: "pospsendphoto") ?? ""
        
    }
    
    func loanDetails(){
        
        empName = UserDefaults.standard.string(forKey: "loansendname") ?? ""
        empEmail = UserDefaults.standard.string(forKey: "loansendemail") ?? ""
        empMobileNo = UserDefaults.standard.string(forKey: "loansendmobile") ?? ""
        empDesignation = UserDefaults.standard.string(forKey: "loansenddesignation") ?? ""
        PhotoUrl = UserDefaults.standard.string(forKey: "loansendphoto") ?? ""
        
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func shareBtnCliked(_ sender: Any)
    {
         // let text = "This is the text...."
     //   guard let image = NSURL(string:detailImg) else {return }
        

       
//        let img: UIImage = detailImgView
//        saveImage(image: img, filename: "salesMaterial.jpg") //This is where you change your extension name
//        
//        let newImage: UIImage = loadImageFromName(name: "salesMaterial.jpg") //Retrieve your image with the correct extension
//        
//        share(shareText: "Image going to Instagram", shareImage: newImage)
//
        
        ///2 /////
       // let shareAll =  [image  ] as [Any]
        let title = "Finmart"
      
        let shareAll: [Any] = [ empName,empDesignation,empMobileNo,empEmail , URL(string: detailImg)!]

        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.setValue(title, forKey: "Subject")
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        ////////evd 2 ///////
        
        ///3 /////
        
        //    generateImage(strUrl: detailImg)
        
        //////end 3////////
        

    
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
          KYDrawer.modalPresentationStyle = .fullScreen
        self.present(KYDrawer, animated: true, completion: nil)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            DispatchQueue.main.async() {
                let img = UIImage(data: data)
                
                
            }
        }
    }
    
    //Retrieve the correct directory URL
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //Saving an image to that directory
    func saveImage (image: UIImage, filename: String ){
        print("Saving image with name \(filename)")
        if let data = image.pngData() {
            let fullURL = getDocumentsDirectory().appendingPathComponent(filename)
            try? data.write(to: fullURL)
        }
    }
    
    //Retrieving an image from the directory
    func loadImageFromName(name: String) -> UIImage? {
        print("Loading image with name \(name)")
        let path = getDocumentsDirectory().appendingPathComponent(name).path
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        return image
    }
    
    
    ////////////////////////////////// Not Used ///////////////////////////////////////////////////////
    
    // MARK: bfbdbdbdbd
    private func generateImage(strUrl : String){
        
        
//        let alertView:CustomIOSAlertView = FinmartStyler.getLoadingAlertViewWithMessage("Please Wait...")
//        if let parentView = self.navigationController?.view
//        {
//            alertView.parentView = parentView
//        }
//        else
//        {
//            alertView.parentView = self.view
//        }
//        alertView.show()
        
        var filename = "salesMaterial1"
        
        let request = URLRequest(url:  URL(string: strUrl )!)
        let config = URLSessionConfiguration.default
        let session =  URLSession(configuration: config)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            if error == nil{
                if let pdfData = data {
                    let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(filename).png")
                    
                    
                   
                    do {
                         //alertView.close()
                        print("open \(pathURL.path)")
                       
                         try pdfData.write(to: pathURL)

                        
                    }catch{
                        print("Error while writting")
                       // alertView.close()
                    }
                        
                    
                    DispatchQueue.main.async {
                        
                        self.sharePdf(path: pathURL)
                    }
                 
                    
                    
                }
            }else{
                print(error?.localizedDescription ?? "")
                //alertView.close()
            }
        }); task.resume()
    }
    
    
    
    // Share Pdf Using Path
    func sharePdf(path:URL) {
        
        let shareText = "This is the text...."

      //  let shareAll =  [ path,shareText ] as [Any]
        
        var objectsToShare = [AnyObject]()
       
        objectsToShare.append(path as AnyObject)
        objectsToShare.append(shareText as AnyObject)
      
        
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path.path) {
            
            // Below is Default Sharing
                        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                        activityViewController.popoverPresentationController?.sourceView = self.view
            
            
            
            //avoiding to crash on iPad
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popoverController.sourceView = self.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }

            self.present(activityViewController, animated: true, completion: nil)
            
            
            
            
            
            // For Showing Preview
            
//            let controller = UIDocumentInteractionController(url: path)
//            controller.delegate = self
//            controller.presentPreview(animated: true)
            
        }
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        
        return self
    }
    
}
