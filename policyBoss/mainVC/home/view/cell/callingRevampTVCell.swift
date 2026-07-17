//
//  callingRevampTVCell.swift
//  MagicFinmart
//
//  Created by iOS Developer on 15/07/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol callingrevampDelegate: AnyObject {
    func callingshareBtnTapped(cell: callingRevampTVCell)
    func callingcallBtnTapped(cell: callingRevampTVCell)
}

class callingRevampTVCell: UITableViewCell {
    
    weak var callingDelegate : callingrevampDelegate?

    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet var managerNameLbl: UILabel!
    @IBOutlet weak var mobLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    @IBAction func callBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        callingDelegate?.callingcallBtnTapped(cell: self)
    }
    
    @IBAction func emailBtnCliked(_ sender: Any)
    {
        callingDelegate?.callingshareBtnTapped(cell: self)
    }
    
}
