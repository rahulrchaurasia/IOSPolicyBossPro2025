//
//  helpnfeedbackVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 27/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class helpnfeedbackVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableArr = ["CONTACT US"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backBtnCliked(_ sender: Any)
    {
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
         KYDrawer.modalPresentationStyle = .fullScreen
        present(KYDrawer, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! helpnfeedbckTVCell
        
        cell.cellLbel.text = tableArr[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0)
        {
            let hnfcontactUs : hnfcontactUsVC = self.storyboard?.instantiateViewController(withIdentifier: "stbhnfcontactUsVC") as! hnfcontactUsVC
            hnfcontactUs.modalPresentationStyle = .fullScreen
            hnfcontactUs.modalTransitionStyle = .coverVertical
            present(hnfcontactUs, animated: false, completion: nil)
        }
       
//        else if(indexPath.row == 1)
//        {
//
//            let commonWeb : commonWebVC = self.storyboard?.instantiateViewController(withIdentifier: "stbcommonWebVC") as! commonWebVC
//            commonWeb.modalPresentationStyle = .fullScreen
//            commonWeb.modalTransitionStyle = .coverVertical
//            commonWeb.webfromScreen = "DISCLOSURE"
//            commonWeb.addType = "CHILD"
//            add(commonWeb)
//        }
        
    }
    
}
