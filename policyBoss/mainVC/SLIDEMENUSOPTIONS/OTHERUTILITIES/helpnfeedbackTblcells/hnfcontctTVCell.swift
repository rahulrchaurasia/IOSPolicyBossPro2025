//
//  hnfcontctTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol mycelDelegate: AnyObject {
    func btnWebsiteTapped(cell: hnfcontctTVCell)
    func btnEmailTapped(cell: hnfcontctTVCell)
    func btnPhonenoTapped(cell: hnfcontctTVCell)
}


class hnfcontctTVCell: UITableViewCell {

    //2.
    weak var delegate: mycelDelegate?
    
    @IBOutlet weak var contctusView: UIView!
    @IBOutlet weak var displayTitlLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let borderColor = UIColor.lightGray
        contctusView.layer.cornerRadius=5.0;
        contctusView.layer.borderWidth=1.0;
        contctusView.layer.borderColor=borderColor.cgColor;
        
    }


    //--<calling Third party url>--
    @IBAction func phoneNoCliked(_ sender: Any)
    {
        
        //check delegate is not nil with `?`
        delegate?.btnPhonenoTapped(cell: self)
    }
    
    @IBAction func emailCliked(_ sender: Any)
    {
        //check delegate is not nil with `?`
        delegate?.btnEmailTapped(cell: self)
    }
    
    @IBAction func websiteCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.btnWebsiteTapped(cell: self)
    }

    
}
