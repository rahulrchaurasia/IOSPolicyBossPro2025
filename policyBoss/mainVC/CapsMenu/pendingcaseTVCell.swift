//
//  pendingcaseTVCell.swift
//  MagicFinmart
//
//  Created by Admin on 16/01/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

//1. delegate method
protocol MyCellDelegate: AnyObject {
    func btnDeleteTapped(cell: pendingcaseTVCell)
    //leadHistoryDelegates
    func leadHistoryTapped(cell: pendingcaseTVCell)
}




class pendingcaseTVCell: UITableViewCell {
    //2.
    weak var delegate: MyCellDelegate?
    @IBOutlet weak var pendingcaseTVCellView: UIView!
    @IBOutlet weak var pendingtitleLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var pendingdyLbl: UILabel!
    @IBOutlet weak var qtypecirclLbl: UILabel!
    @IBOutlet weak var qtypeLbl: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    @IBOutlet weak var pendingDltBtn: UIButton!
    @IBOutlet weak var percentageLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    
    @IBOutlet weak var leadHistoryBtn: UIButton!
    
    
    //  closure
    /*******************************************************/
    var tapPhonePending: ( () -> Void)? = nil
    
    var tapMessagePending: ( () -> Void)? = nil
    
    /*******************************************************/
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let borderColor = UIColor.init(red: 0/255.0, green: 125/255.0, blue: 213/255.0, alpha: 1)
        pendingdyLbl.layer.borderWidth=1.0;
        pendingdyLbl.layer.borderColor=borderColor.cgColor;
        pendingdyLbl.layer.cornerRadius = pendingdyLbl.frame.size.width/2
        pendingdyLbl.clipsToBounds = true
//        qtypeLbl.layer.borderWidth=1.0;
//        qtypeLbl.layer.borderColor=borderColor.cgColor;
//        qtypeLbl.layer.cornerRadius = qtypeLbl.frame.size.width/2
//        qtypeLbl.clipsToBounds = true
        
    }

    @IBAction func pendingDltBtnCliked(_ sender: Any)
    {
        // Delete Pending Case
        //4. call delegate method
        //check delegate is not nil with `?`
        delegate?.btnDeleteTapped(cell: self)
    }
    
    
//    @IBAction func leadHistoryBtnCliked(_ sender: Any) {
//        delegate?.leadHistoryTapped(cell:self)
//    }
//
    
    
    @IBAction func btnPendingCalling(_ sender: Any) {
        
         tapPhonePending?()
    }
    
    
    @IBAction func btnPendingEmail(_ sender: Any) {
        
         tapMessagePending?()
    }
    
    @IBAction func btnLeadHistory(_ sender: Any) {
        
           delegate?.leadHistoryTapped(cell:self)
    }
}
