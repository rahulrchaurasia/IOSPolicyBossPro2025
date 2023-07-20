//
//  AlertPospAmntVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 29/06/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import UIKit

class AlertPospAmntVC: UIViewController ,  UITableViewDataSource , UITableViewDelegate{

    
    var alertTitle = String()
     
    var  pospAmntData =   String()
   var  pospAmntList =  [String]()
     
    var alertSubTitle = String()
    
    
    @IBOutlet weak var tblPospAmntDtl: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblPospAmntDtl.delegate = self
        tblPospAmntDtl.dataSource = self
        
         pospAmntList = pospAmntData.components(separatedBy: "|")
        
        lblTitle.text = alertTitle
        
        lblSubTitle.text = alertSubTitle
        
       
//        DispatchQueue.main.async {
//            self.pospAmntTableView.reloadData()
//
//        }
    }
    

    @IBAction func btnClose(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func btnOK(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pospAmntList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell : pospAmntAlertTVCell =
        tableView.dequeueReusableCell(withIdentifier: "cell") as! pospAmntAlertTVCell
        
        cell.configureCell(strDetail: pospAmntList[indexPath.row])
        return cell
        
    }

}


