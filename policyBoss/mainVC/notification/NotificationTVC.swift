//
//  NotificationTVC.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 24/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var imgNotify: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(data : NotificationData){
        
        lblTitle.text = data.title
       
        lblDescription.text = data.body
       
        lblDate.text = data.date
        
        
        if let imageURL = data.img_url{
            
            if(!imageURL.isEmpty){
                let remoteImageURL = URL(string: imageURL)
                imgNotify.sd_setImage(with: remoteImageURL)
            }else{
                
                imgNotify.image = UIImage(named: "notification_ic")
            }
        }else{
            imgNotify.image = UIImage(named: "notification_ic")
        }
        
       
       
    }
}
