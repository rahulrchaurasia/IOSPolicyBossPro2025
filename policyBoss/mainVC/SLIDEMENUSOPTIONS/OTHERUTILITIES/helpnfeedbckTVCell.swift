//
//  reqpolicyTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class helpnfeedbckTVCell: UITableViewCell {

    @IBOutlet weak var helpnfeedbckcellView: UIView!
    @IBOutlet weak var cellLbel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let borderColor = UIColor.lightGray
        helpnfeedbckcellView.layer.cornerRadius=2.0;
        helpnfeedbckcellView.layer.borderWidth=1.0;
        helpnfeedbckcellView.layer.borderColor=borderColor.cgColor;
        
    }

  
}
