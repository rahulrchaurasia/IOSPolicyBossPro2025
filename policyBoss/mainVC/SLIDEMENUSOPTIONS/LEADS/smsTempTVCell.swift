//
//  smsTempTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 23/05/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol smscellDelegates: AnyObject {
    func smsBtnTapped(cell: smsTempTVCell)
}

class smsTempTVCell: UITableViewCell {

    //2.
    weak var smsmdelegate: smscellDelegates?
    
    @IBOutlet var smscellView: UIView!
    @IBOutlet var smscellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let borderColr = UIColor.lightGray
//        smscellView.layer.cornerRadius=2.0;
//        smscellView.layer.borderWidth=1.0;
//        smscellView.layer.borderColor=borderColr.cgColor;
        //        Btn.setTitleColor(UIColor.gray, for: .normal)
        //shadowColor for uiview
        smscellView.layer.cornerRadius = 4.0
        smscellView.layer.shadowColor = UIColor.gray.cgColor
        smscellView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        smscellView.layer.shadowRadius = 10.0
        smscellView.layer.shadowOpacity = 0.8
    }

   
    @IBAction func smsBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        smsmdelegate?.smsBtnTapped(cell: self)
    }
    
}
