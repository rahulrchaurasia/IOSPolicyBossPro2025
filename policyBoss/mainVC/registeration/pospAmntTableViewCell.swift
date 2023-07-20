//
//  pospAmntTableViewCell.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/06/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import UIKit

class pospAmntTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgCheck: UIImageView!
    
    @IBOutlet weak var lblPospAmnt: UILabel!
    
    @IBOutlet weak var imgInfo: UIImageView!
    
    var tapPospAmntInfo: ( () -> Void)? = nil
    
    var tapPospAmntCheck: ( () -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj : MasterDataPospAmnt){
        
        lblPospAmnt.text = obj.posp_name
        
       
           
    }
    
    @IBAction func btnInfoClick(_ sender: Any) {
        
        tapPospAmntInfo?()
    }
    
    
    @IBAction func btnCheck(_ sender: Any) {
       
        tapPospAmntCheck?()
        
    }
    
    
    
    
}
