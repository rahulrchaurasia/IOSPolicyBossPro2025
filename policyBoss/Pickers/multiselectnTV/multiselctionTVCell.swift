//
//  multiselctionTVCell.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class multiselctionTVCell: UITableViewCell {

     var tapCheckClicked: ( () -> Void)? = nil
    
    @IBOutlet weak var tableLbl: UILabel!
    
    @IBOutlet weak var tableCheckbox: UIImageView!
    
    
//    @IBAction func btnCheckBoxClick(_ sender: Any) {
//
//         tapCheckClicked?()
//
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // update UI
      //  accessoryType = selected ? .checkmark : .none
    }
}
