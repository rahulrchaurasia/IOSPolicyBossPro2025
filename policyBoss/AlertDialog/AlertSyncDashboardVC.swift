//
//  AlertSyncDashboardVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 30/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit

class AlertSyncDashboardVC: UIViewController {
    
    typealias syncDashCompetionHandler = ([String: Any]) -> Void

    var syncDashboardCompletion : syncDashCompetionHandler?
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnDashboard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }
    
    
    func initView(){
        
        viewMain.layer.cornerRadius = 10
        
        btnDashboard.layer.cornerRadius = 15
        btnDashboard.layer.borderWidth = 2
        btnDashboard.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0.7929946192)
        
    }

   
    @IBAction func btnDashboardClick(_ sender: Any) {
        
       
        self.dismiss(animated: true)
        
        let dict = ["DASHBOARD": "Y"]
        syncDashboardCompletion?(dict)
    }
    
  
}
