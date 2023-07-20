//
//  NotificationListVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 24/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit
import TTGSnackbar

class NotificationListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var notificationTableView: UITableView!
    var notificationList = [NotificationData?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        
        activityIndicator.isHidden = true
       
        
        fetchNotificationHistory()
       
    }
    
    func   fetchNotificationHistory() {
        
        
       // getshortLink
        if Connectivity.isConnectedToInternet(){
                   
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            NotificationViewModel.shareInstance.getNotificationData()
            { [weak self] (result) in
                       
                       //alertView.close()
                
                DispatchQueue.main.async {
                    
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    
                    
                    switch result {
                        
                    case .success(let objResponse):
                        
                        if let reponse = objResponse as? NotificationResponse{
                            
                            debugPrint("Response",reponse)
                            

                            self?.notificationList = reponse.MasterData
                                
                            self?.notificationTableView.reloadData()
                            
                        }
                        
                       
                        
                        
                        
                    case .failure(.custom(message: let error)):
                        
                      
                            
                            self?.activityIndicator.isHidden = true
                            self?.activityIndicator.stopAnimating()
                            
                            let snackbar = TTGSnackbar.init(message: error, duration: .middle )
                            
                            snackbar.show()
                            
                        
                    }
                }
                
                   }
               }else{
                
                   let snackbar = TTGSnackbar.init(message: Connectivity.message, duration: .middle )
                   snackbar.show()
                   self.activityIndicator.isHidden = true
                   self.activityIndicator.stopAnimating()
               }
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificationTVC
        
        cell.configureCell(data: notificationList[indexPath.row]!)
        
        
        return cell
        
    }
    
    
}
extension NotificationListVC {
    
    static func shareInstance() -> NotificationListVC
    {
        return NotificationListVC.initiateFromStoryboard(name: storyBoardName.Notification)
    }
}
