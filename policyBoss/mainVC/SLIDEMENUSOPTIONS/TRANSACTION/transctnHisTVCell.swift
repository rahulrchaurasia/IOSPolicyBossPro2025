//
//  transctnHisTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 14/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class transctnHisTVCell: UITableViewCell {

    @IBOutlet weak var transctnCellView: UIView!
    @IBOutlet weak var trantitleLbl: UILabel!
    @IBOutlet weak var tranentryNameLbl: UILabel!
    @IBOutlet weak var traninsurerLbl: UILabel!
    @IBOutlet weak var tranpremiumLbl: UILabel!
    @IBOutlet weak var tranentryDateLbl: UILabel!
    @IBOutlet weak var trantotalOdLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //border
        let borderColor = UIColor.gray
        transctnCellView.layer.cornerRadius=5;
        transctnCellView.layer.borderWidth=1.0;
        transctnCellView.layer.borderColor=borderColor.cgColor;
        
    }

    
}
