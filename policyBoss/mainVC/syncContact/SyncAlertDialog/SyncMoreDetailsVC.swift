//
//  SyncMoreDetailsVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 16/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit

class SyncMoreDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func btnCLose(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}
extension SyncMoreDetailsVC {
    
    static func shareInstance() -> SyncMoreDetailsVC
    {
        return SyncMoreDetailsVC.initiateFromStoryboard(name: storyBoardName.SyncContact)
    }
}

