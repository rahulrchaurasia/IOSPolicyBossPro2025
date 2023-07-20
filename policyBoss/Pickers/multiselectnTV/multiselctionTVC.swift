//
//  multiselctionTVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

protocol selectedDataDelegate
{
    func getselectedData(insuranceCompObj: InsuranceCompModel?, selectedData : [String], selectedID : [String], stringId : String)
}

class multiselctionTVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var delegateData : selectedDataDelegate?
    
    @IBOutlet weak var slectnTV: UITableView!
    
    var fromScreen = ""
    var tableArray = [String]()
    var selectedData = [String]()
    var selectedID = [String]()
    var stringId = ""
    var insuranceCompObj: InsuranceCompModel? = nil
    
     var insuranceLifeData = [InsuranceData]()
    
//    var lyfInsArray = ["Aen Life","Aviva","Bajaj","Bharti AXA","Birla","CanaraHSBC","DLF","Edelwiess","ExideLife","Future Ge","HDFC","ICICI","IDBIFedera","IndiaFirst","Kotak Life","LIC","MaxNewyork","MetLife","PostalLife","Reliance","SAHARALife","SBI Life","Shriram","Star Unio","Tata AIG","UTI"]
//    var genrlInsArray = ["Agri.Ins","Apollo","Bajaj","Bharti","Chola","Cigna TTK","Exp-Credit","Future Gen","HDFC","ICICI","IFFCO","Kotak","L & T Insurance","Liberty Videocon","Magma","Max Bupa","National","New India","Oriental","Raheja","Reliance","Religare","SBI General","Shriram","Star Health","Sundaram","Tata AIG","Uni.Sompo","United"]
//    var healthInsArray = ["Agri.Ins","Apollo","Cigna TTK","Exp-Credit","Future Gen","Max Bupa","Religare","Star Health","Uni.Sompo"]
//
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fromScreen=",fromScreen)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(fromScreen == "lifeInsurance")
        {
           // return lyfInsArray.count
            //return self.insuranceCompObj?.MasterData.lifeinsurance.count ?? 0
            return insuranceLifeData.count
        }
        else if(fromScreen == "genInsurance")
        {
           // return genrlInsArray.count
            return self.insuranceCompObj?.MasterData.generalinsurance.count ?? 0
        }
        else if(fromScreen == "healthInsurance")
        {
            //return healthInsArray.count
              return self.insuranceCompObj?.MasterData.healthinsurance.count ?? 0
        }else
        {
            return tableArray.count
        }

    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = slectnTV.dequeueReusableCell(withIdentifier: "cell") as! multiselctionTVCell
        
//        cell.tableLbl.text! = tableArray[indexPath.row]
       
       cell.selectionStyle = .none
        
        
        
        
        // When Alert Dialog Info Button Click
//        cell.tapCheckClicked = {
//
//
//
//        }
//
       
        if(fromScreen == "lifeInsurance")
        {
          
            cell.tableLbl.text! =  self.insuranceCompObj?.MasterData.lifeinsurance[indexPath.row].InsuShorName ?? ""
            if(self.insuranceCompObj?.MasterData.lifeinsurance[indexPath.row].selected ?? false == false){

           
                 cell.accessoryType = .none
            }else{
                
                 cell.accessoryType = .checkmark

            }
            
            
//            cell.tableLbl.text! = insuranceLifeData[indexPath.row].InsuShorName
//            if(insuranceLifeData[indexPath.row].IsSelected == true){
//              cell.accessoryType = .checkmark
//
//            }else{
//                 cell.accessoryType = .none
//
//            }
            
            
            
        }
        else if(fromScreen == "genInsurance")
        {

            cell.tableLbl.text! =  self.insuranceCompObj?.MasterData.generalinsurance[indexPath.row].InsuShorName ?? ""

            if(self.insuranceCompObj?.MasterData.generalinsurance[indexPath.row].selected ?? false == false){
                
                 cell.accessoryType = .none

            }else{

                  cell.accessoryType = .checkmark
            }
        }
        
        
        else if(fromScreen == "healthInsurance")
        {

              cell.tableLbl.text! =  self.insuranceCompObj?.MasterData.healthinsurance[indexPath.row].InsuShorName ?? ""

            if(self.insuranceCompObj?.MasterData.healthinsurance[indexPath.row].selected ?? false == false){
                
                cell.accessoryType = .none
                
            }else{
                 cell.accessoryType = .checkmark
                

            }
        }
        
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//
//        if(fromScreen == "lifeInsurance")
//        {
//            insuranceLifeData[indexPath.row].IsSelected = false
//            slectnTV.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
//        slectnTV.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        if(fromScreen == "lifeInsurance")
        {

            stringId = "lyf"
         
            
            
            if(self.insuranceCompObj?.MasterData.lifeinsurance[indexPath.row].selected ?? false == false){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
               
                 self.insuranceCompObj?.MasterData.lifeinsurance[indexPath.row].selected = true
                
            }else{
                 tableView.cellForRow(at: indexPath)?.accessoryType = .none
                  self.insuranceCompObj?.MasterData.lifeinsurance[indexPath.row].selected = false
               
            }
           
            
//            if(insuranceLifeData[indexPath.row].IsSelected == false){
//
//                insuranceLifeData[indexPath.row].IsSelected = true
//                 tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//
//            }else{
//
//                 insuranceLifeData[indexPath.row].IsSelected = false
//                 tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            }
//
            
            
            

        }
            
            
        else if(fromScreen == "genInsurance")
        {
       
            stringId = "gen"
            
            if(self.insuranceCompObj?.MasterData.generalinsurance[indexPath.row].selected ?? false == false){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.insuranceCompObj?.MasterData.generalinsurance[indexPath.row].selected = true
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.insuranceCompObj?.MasterData.generalinsurance[indexPath.row].selected = false
            }
        }
        
        
        
        else if(fromScreen == "healthInsurance")
        {
          
            stringId = "health"

            if(self.insuranceCompObj?.MasterData.healthinsurance[indexPath.row].selected ?? false == false){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.insuranceCompObj?.MasterData.healthinsurance[indexPath.row].selected = true
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.insuranceCompObj?.MasterData.healthinsurance[indexPath.row].selected = false
            }
        }
        
    }
    
    
    
    
    /////
    
    func getSelectedInsurance(){
        
        
        selectedData.removeAll()
        selectedID.removeAll()
     if(fromScreen == "lifeInsurance"){
        
        if(self.insuranceCompObj?.MasterData.lifeinsurance.count ?? 0 > 0){

             for index in 0...(self.insuranceCompObj?.MasterData.lifeinsurance.count ?? 0)-1 {

                if(self.insuranceCompObj?.MasterData.lifeinsurance[index].selected ?? false  == true){

                    selectedID.append(String(self.insuranceCompObj?.MasterData.lifeinsurance[index].InsuID ?? 0))
                    selectedData.append(String(self.insuranceCompObj?.MasterData.lifeinsurance[index].InsuShorName ?? ""))
                }
            }

         }
//         for index in 0...(self.insuranceLifeData.count)-1 {
//
//             if(insuranceLifeData[index].IsSelected == true){
//                selectedID.append(String(insuranceLifeData[index].InsuID))
//                selectedData.append(String(insuranceLifeData[index].InsuShorName))
//            }
//        }
        
      }
        
        
       else if(fromScreen == "genInsurance"){
            
            if(self.insuranceCompObj?.MasterData.generalinsurance.count ?? 0 > 0){
                
                for index in 0...(self.insuranceCompObj?.MasterData.generalinsurance.count ?? 0)-1 {
                    
                    if(self.insuranceCompObj?.MasterData.generalinsurance[index].selected ?? false  == true){
                        
                        selectedID.append(String(self.insuranceCompObj?.MasterData.generalinsurance[index].InsuID ?? 0))
                        selectedData.append(String(self.insuranceCompObj?.MasterData.generalinsurance[index].InsuShorName ?? ""))
                    }
                }
                
            }
            
        }
        
        
       else if(fromScreen == "healthInsurance"){
            
            if(self.insuranceCompObj?.MasterData.healthinsurance.count ?? 0 > 0){
                
                for index in 0...(self.insuranceCompObj?.MasterData.healthinsurance.count ?? 0)-1 {
                    
                    if(self.insuranceCompObj?.MasterData.healthinsurance[index].selected ?? false  == true){
                        
                        selectedID.append(String(self.insuranceCompObj?.MasterData.healthinsurance[index].InsuID ?? 0))
                        selectedData.append(String(self.insuranceCompObj?.MasterData.healthinsurance[index].InsuShorName ?? ""))
                    }
                }
                
            }
            
        }
        
    }
    

    @IBAction func tableCancelBtnCliked(_ sender: Any)
    {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    @IBAction func tableOkBtnCliked(_ sender: Any)
    {
        getSelectedInsurance()
        print("selectedData=",selectedData)
        print("stringId=",stringId)
        self.delegateData?.getselectedData( insuranceCompObj: insuranceCompObj , selectedData : selectedData,selectedID: selectedID, stringId: stringId)
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
 
        
    }
    
    
    
    
}
