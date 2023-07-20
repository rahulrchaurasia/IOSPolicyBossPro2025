//
//  SalesmaterialVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 14/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit
import CustomIOSAlertView
import TTGSnackbar


class SalesmaterialVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,salesDelegate{
   
   
    
   
    
    
    @IBOutlet weak var salesMTView: UITableView!
    @IBOutlet weak var salesmaterialdownldView: UIView!
    @IBOutlet weak var salesmaterialViewLbl: UILabel!
    @IBOutlet weak var salesmaterialdownldbckView: UIView!
    
    var isUpdate = false
    var selectedRow = 0
    
    var ProductNameArray = [String]()
    var ProductimageArray = [String]()
    var CountArray = [Int]()
    var ProductIdArray = [Int]()
    var countstringArray = [String]()
    var ProductIdstringArray = [Int]()
    var productID = ""
    var productName = ""
    var productCnt = Int()
    var fromScreen = ""
    var sMaterialModel = [salesMaterialModel]()
    var indexR = Int()
    
    var productCount = Int()
    
    ///////////
    
    var indexTbl = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        salesmaterialdownldbckView.isHidden = true
        //        salesmaterialdownldView.isHidden = true
        
        //--<apiCall>--
        salesmaterialproductAPI()
        
    }
    
    @IBAction func salesMaterialBackBtn(_ sender: Any)
    {
        dismiss(animated: false)
        
    }
    
    @IBAction func homeBtnCliked(_ sender: Any)
    {
        dismiss(animated: false)
        
    }
    
    func deSelectData(){
        
        if let index = salesMTView.indexPathForSelectedRow{
            self.salesMTView.deselectRow(at: index, animated: false)
        }
    }
    
    func resetSalesData(){
        
      //  let cell = collectionView.cellForItem(at: indexPath)  as! insalesmaterialCVCell

        if let cell = salesMTView.cellForRow(at: indexTbl)  as?  salesmaterialTVCell{
            
            cell.salescellCountLbl.text = ""
            cell.salescellCountLbl.isHidden = true

           self.salesMTView.deselectRow(at: indexTbl, animated: false)
        }
        
    }
    
    //---<tableView Datasource+Delegates>---
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ProductNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = salesMTView.dequeueReusableCell(withIdentifier: "cell") as! salesmaterialTVCell
        
        cell.salescellCountLbl.layer.cornerRadius = cell.salescellCountLbl.frame.size.width/2
        cell.salescellCountLbl.clipsToBounds = true
        salesMTView.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        //shadowColor for uiview
        cell.salescellView.layer.cornerRadius = 4.0
        cell.salescellView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.salescellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.salescellView.layer.shadowRadius = 10.0
        cell.salescellView.layer.shadowOpacity = 0.8
        
        
        cell.salescellLbl.text! = ProductNameArray[indexPath.row]
        //        cell.salescellCountLbl.text! = countstringArray[indexPath.row]
        //loadimages
        //        let imgURL = NSURL(string: ProductimageArray[indexPath.row])
        //        if imgURL != nil {
        //            let data = NSData(contentsOf: (imgURL as URL?)!)
        //            cell.salesmcellImgView.image = UIImage(data: data! as Data)
        //        }
        
        if let imgURL = URL(string: ProductimageArray[indexPath.row]){
            
            
            cell.salesmcellImgView.sd_setImage(with: imgURL)
        }
        
        //       let productCnt = UserDefaults.standard.string(forKey: "productCnt")
        //        print("productCnt=",productCnt!)
        //       let indexR = UserDefaults.standard.string(forKey: "indexR")
        
        let mod = sMaterialModel[indexPath.row]
        let pCount = mod.productCount
        let proCount = String(pCount)
        // 05
        
        productID = String(ProductIdstringArray[indexPath.row])
        
        if(productID == "7"){
            
            cell.salescellCountLbl.text = ""
            cell.salescellCountLbl.isHidden = true
            
        }else{
            cell.salescellCountLbl.text = proCount
            cell.salescellCountLbl.isHidden = false
        }
        
        
        //        if(fromScreen == "passindex")
        //        {
        //            if(indexR != nil){
        //
        //
        //                if(productCnt == proCount)
        //                {
        //                    cell.salescellCountLbl.text = proCount
        //                    cell.salescellCountLbl.isHidden = true
        //                }else{
        //                    cell.salescellCountLbl.text = proCount
        //                    cell.salescellCountLbl.isHidden = false
        //                }
        //            }
        //            else{
        //                if(productCnt != proCount)
        //                {
        //                    cell.salescellCountLbl.text = proCount
        //                    cell.salescellCountLbl.isHidden = false
        //                }
        //            }
        //
        //        }else{
        //            cell.salescellCountLbl.text = proCount
        //        }
        //
        
        if (self.isKeyPresentInUserDefaults(key:"SalesProductCount")) {
            
            print("table SalesProductCount Present")
            let oldCountArray = UserDefaults.standard.array(forKey: "SalesProductCount")  as? [Int] ?? [Int]()
            print("table Old Count",oldCountArray)
            if( sMaterialModel[indexPath.row].productCount == oldCountArray[indexPath.row]){
                
                
                cell.salescellCountLbl.isHidden = true
            }else{
                cell.salescellCountLbl.isHidden = false
                
                let tempCount =  sMaterialModel[indexPath.row].productCount - oldCountArray[indexPath.row]
                cell.salescellCountLbl.text = String(tempCount)
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! salesmaterialTVCell
        
        indexTbl = indexPath
        cell.salescellCountLbl.layer.cornerRadius = cell.salescellCountLbl.frame.size.width/2
        cell.salescellCountLbl.clipsToBounds = true
        salesMTView.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        //shadowColor for uiview
        cell.salescellView.layer.cornerRadius = 4.0
        cell.salescellView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.salescellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.salescellView.layer.shadowRadius = 10.0
        cell.salescellView.layer.shadowOpacity = 0.8
        
        //        cell.salescellCountLbl.isHidden = true
        productID = String(ProductIdstringArray[indexPath.row])
        productName = ProductNameArray[indexPath.row]
        let mod = sMaterialModel[indexPath.row]
        productCnt = mod.productCount
        UserDefaults.standard.set(String(describing: productCnt), forKey: "productCnt")
        
        indexR = indexPath.row
        UserDefaults.standard.set(String(describing: indexR), forKey: "indexR")
        
        
        
        
        if (cell.salescellCountLbl.isHidden == false)
        {
            salesmaterialdownldbckView.isHidden = false
            salesmaterialViewLbl.text! = String(sMaterialModel[indexPath.row].productCount) + " new Images are available for downloading."
            
             
        }
        else{
            deSelectData()
            cell.salescellCountLbl.isHidden = true
            let insalesmaterial : insalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbinsalesmaterialVC") as! insalesmaterialVC
            insalesmaterial.modalPresentationStyle = .fullScreen
            insalesmaterial.modalTransitionStyle = .coverVertical
            insalesmaterial.productId = String(ProductIdstringArray[indexPath.row])
            insalesmaterial.passindexlbl = ProductNameArray[indexPath.row]
//            self.addChild(insalesmaterial)
//            self.view.addSubview(insalesmaterial.view)
            
            self.present(insalesmaterial,animated: false,completion: nil)
            
            
            /////////////////////////////////
            
            print("Row Selected Count", sMaterialModel[indexPath.row].productCount)
           // var oldCountArray1 = UserDefaults.standard.array(forKey: "SalesProductCount")  as? [Int] ?? [Int]()
           var oldCountArray = UserDefaults.standard.object(forKey:"SalesProductCount") as? [Int] ?? [Int]()
            oldCountArray[indexPath.row] = sMaterialModel[indexPath.row].productCount
            UserDefaults.standard.set( oldCountArray, forKey: "SalesProductCount")
            
        }
        
        
    }
    
    //---<APICALL>---
    func salesmaterialproductAPI()
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
            let params: [String: AnyObject] = [:]
            
          
             let url = "sales-material-product-pb"
            
            FinmartRestClient.sharedInstance.authorisedPost(url, parameters: params, onSuccess: { (userObject, metadata) in
                alertView.close()
                
                self.view.layoutIfNeeded()
                
                let jsonData = userObject as? NSArray
                
                
                
                //             if (jsonData?.count)! > 0{
                //              UserDefaults.standard.set(jsonData, forKey: "SalesProductData")
                //
                //              let SalesProduct = UserDefaults.standard.object(forKey: "SalesProductData") as! NSArray
                //
                //                        if(SalesProduct.count > 0){
                //                            for index in 0...(SalesProduct.count)-1 {
                //                                let aObject = SalesProduct[index] as! [String : AnyObject]
                //
                //
                //                                print("SALESDATA",aObject["Count"] as! Int)
                //
                //                            }
                //                        }
                //
                //            }
                
                
                let Product_Name = jsonData?.value(forKey: "Product_Name") as AnyObject
                //            print("Product_Name= ", Product_Name)
                self.ProductNameArray = Product_Name as! [String]
                //Convert int to string array
                let Count = jsonData?.value(forKey: "Count") as AnyObject
                self.countstringArray = self.CountArray.map { String($0) }
                
                self.CountArray = Count as! [Int]
                
                
                let Product_Id = jsonData?.value(forKey: "Product_Id") as AnyObject
                self.ProductIdArray = Product_Id  as! [Int]
                
                self.ProductIdstringArray = self.ProductIdArray
                
                let Product_image = jsonData?.value(forKey: "Product_image") as AnyObject
                self.ProductimageArray = Product_image as! [String]
                
                ////////////////////////////
                
                
                if (jsonData?.count)! > 0{
                    self.sMaterialModel = [salesMaterialModel]()
                    for index in 0...(jsonData?.count)!-1 {
                        let aObject = jsonData?[index] as! [String : AnyObject]
//                        let model1 = salesMaterialModel(productCount: aObject["Count"] as! Int ,Product_Id : aObject["Product_Id"] as! Int)
                        
                        let model1 = salesMaterialModel(productCount: aObject["Count"] as! Int , Product_Id: aObject["Product_Id"] as! Int )
                        model1.productOldCount = 0
                        
//                        if(model1.product_Id != 4 ||  model1.product_Id != 4){
//
//                        }
                        self.sMaterialModel.append(model1)//+=[model1]
                        
                        
                        
                    }
                    
                    
                }
                //////
                
                
                if (self.isKeyPresentInUserDefaults(key:"SalesProductData")   &&    self.isKeyPresentInUserDefaults(key:"SalesProductCount") ) {
                    
                    print("Old Product Present")
                    //  if (self.isKeyPresentInUserDefaults(key:"SalesProductCount")) {
                    
                    let  compLst = UserDefaults.standard.object(forKey: "SalesProductData") as! NSArray
                    
                    let oldCountArray = UserDefaults.standard.array(forKey: "SalesProductCount")  as? [Int] ?? [Int]()
                    
                    if(compLst.count > 0){
                        
                        
                        
                        // case 1 : for first time when db data is empty OR Server list size is change ie product is increased / decreased
                        
                        if(compLst.count != self.sMaterialModel.count  || self.isUpdate ){
                            
                            var OldCountArray = [Int]()
                            for currObject in self.sMaterialModel{
                                
                                OldCountArray.append(0)
                                print("OldCount set 1 : 0")
                            }
                            
                            UserDefaults.standard.set(jsonData, forKey: "SalesProductData")
                            UserDefaults.standard.set( OldCountArray, forKey: "SalesProductCount")
                            
                        } else{
                            
                            for currObject in self.sMaterialModel{
                                
                                //print("SALESDATA_1",currObject.productCount )
                                
                                for index in 0...(compLst.count)-1 {
                                    let oldObject = compLst[index] as! [String : AnyObject]
                                    // print("SALESDATA_2",oldObject["Count"] as! Int)
                                    
                                    if(currObject.product_Id   == oldObject["Product_Id"] as! Int ){
                                        
                                        if(oldCountArray[index]  > currObject.productCount){
                                            
                                            self.isUpdate = true
                                            break
                                            
                                        }
                                        
                                        self.sMaterialModel[index].productOldCount = oldCountArray[index]
                                        print("productOldCount",oldCountArray[index])
                                    }
                                    
                                }
                                
                            }
                            // case 2 : if sever product count is lesss than db product count than db should update
                            
                            if(self.isUpdate ){
                                
                                var OldCountArray = [Int]()
                                for currObject in self.sMaterialModel{
                                    
                                    OldCountArray.append(0)
                                    print("OldCount set 2 : 0")
                                }
                                
                                UserDefaults.standard.set(jsonData, forKey: "SalesProductData")
                                UserDefaults.standard.set( OldCountArray, forKey: "SalesProductCount")
                                
                            }
                            
                            
                            //////end case 2        //////
                        }
                        
                    }
                    
                    
                }else{
                    
                    var OldCountArray = [Int]()
                    for currObject in self.sMaterialModel{
                        
                        //  currObject.productOldCount = 0
                        OldCountArray.append(0)
                        print("OldCount set 3 : 0")
                    }
                    
                    UserDefaults.standard.set(jsonData, forKey: "SalesProductData")
                    UserDefaults.standard.set( OldCountArray, forKey: "SalesProductCount")
                    
                }
                
                
                DispatchQueue.main.async {
                    self.salesMTView.reloadData()
                    
                }
                
                
                
                
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
    
    
    @IBAction func closeBtnCliked(_ sender: Any)
    {
        salesmaterialdownldbckView.isHidden = true
         deSelectData()
    }
    
    @IBAction func laterBtnCliked(_ sender: Any)
    {
        salesmaterialdownldbckView.isHidden = true
        deSelectData()
        //        salesmaterialdownldView.isHidden = true
    }
    
    @IBAction func downloadBtnCliked(_ sender: Any)
    {
        
       
        let insalesmaterial : insalesmaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "stbinsalesmaterialVC") as! insalesmaterialVC
        insalesmaterial.modalPresentationStyle = .fullScreen
        insalesmaterial.productId = productID
        insalesmaterial.passindexlbl = productName
        insalesmaterial.tIndex = indexR
        
        insalesmaterial.delegateData = self
//        self.addChild(insalesmaterial)
//        self.view.addSubview(insalesmaterial.view)
          self.present(insalesmaterial,animated: false,completion: nil)
        
        
        print("Row Selected Count", self.sMaterialModel[indexR].productCount)
        var oldCountArray = UserDefaults.standard.array(forKey: "SalesProductCount")  as? [Int] ?? [Int]()
        oldCountArray[indexR] = sMaterialModel[indexR].productCount
        UserDefaults.standard.set(oldCountArray, forKey: "SalesProductCount")    // 05//
        
        
      
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    func selSalesData() {
        
        salesmaterialdownldbckView.isHidden = true
        resetSalesData()
        //deSelectData()
       
    }
    
    
    
}
