//
//  addSubUserTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 16/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class addSubUserTVCell: UITableViewCell {

    @IBOutlet weak var subUserCellView: UIView!
    @IBOutlet weak var celltitleLbl: UILabel!
    @IBOutlet weak var fbaIdLbl: UILabel!
    @IBOutlet weak var adsmobNoLbl: UILabel!
    @IBOutlet weak var adsemailIdLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let borderColor = UIColor.lightGray
        subUserCellView.layer.cornerRadius=4.0;
        subUserCellView.layer.borderWidth=1.0;
        subUserCellView.layer.shadowColor=borderColor.cgColor;
        subUserCellView.layer.borderColor=borderColor.cgColor;
    }

    
    
}
