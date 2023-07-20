//
//  knowGuruTVCell.swift
//  MagicFinmart
//
//  Created by Ashwini on 17/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class knowGuruTVCell: UITableViewCell {

    @IBOutlet weak var knowguruTView: UIView!
    @IBOutlet weak var knowguruCellLbl: UILabel!
    @IBOutlet weak var cellImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
