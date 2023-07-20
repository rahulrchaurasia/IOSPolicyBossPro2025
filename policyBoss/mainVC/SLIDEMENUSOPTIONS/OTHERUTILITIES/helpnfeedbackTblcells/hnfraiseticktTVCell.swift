//
//  hnfraiseticktTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 04/02/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol raiseCmntDelegate: AnyObject {
    func getCmntBtnTapped(cell: hnfraiseticktTVCell)
    func addCmntBtnTapped(cell: hnfraiseticktTVCell)
}

class hnfraiseticktTVCell: UITableViewCell {

    //2.
    weak var raiseticktDelegate: raiseCmntDelegate?
    
    @IBOutlet weak var raisedTcktCellView: UIView!
    @IBOutlet weak var ticktIdLbl: UILabel!
    @IBOutlet weak var ticktStatusLbl: UILabel!
    @IBOutlet weak var ticktCategryLbl: UILabel!
    @IBOutlet weak var discrptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let borderColor = UIColor.lightGray
        raisedTcktCellView.layer.cornerRadius=5.0;
        raisedTcktCellView.layer.borderWidth=1.0;
        raisedTcktCellView.layer.borderColor=borderColor.cgColor;
        
    }
    
    
    @IBAction func viewCmntBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        raiseticktDelegate?.getCmntBtnTapped(cell: self)
    }
    
    @IBAction func cmntaddBtnCliked(_ sender: Any)
    {
        //4. call delegate method
        //check delegate is not nil with `?`
        raiseticktDelegate?.addCmntBtnTapped(cell: self)
    }

}
