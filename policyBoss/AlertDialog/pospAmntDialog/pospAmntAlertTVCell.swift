//
//  pospAmntAlertTVCell.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 29/06/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import UIKit

class pospAmntAlertTVCell: UITableViewCell {

    
    @IBOutlet weak var lblDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(strDetail : String){
        
        lblDetails.text = strDetail
            
    }
}
