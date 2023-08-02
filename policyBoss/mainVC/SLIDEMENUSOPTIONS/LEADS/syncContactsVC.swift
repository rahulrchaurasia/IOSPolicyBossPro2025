//
//  syncContactsVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class syncContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.SyncContactScreen)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: true, completion: nil)
    }
    
}
