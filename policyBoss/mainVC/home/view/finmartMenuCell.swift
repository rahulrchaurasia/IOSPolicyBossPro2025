//
//  finmartMenuCell.swift
//  MagicFinmart
//
//  Created by Ashwini on 17/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class finmartMenuCell: UITableViewCell {

    @IBOutlet weak var cellImgs: UIImageView!
    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(menu : MenuModel){
        
        cellLbl?.text = menu.mName
        cellImgs.image = UIImage(named: menu.mImg)
            
              
    }
}
