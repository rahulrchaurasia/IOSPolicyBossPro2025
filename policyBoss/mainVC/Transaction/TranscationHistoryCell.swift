//
//  TranscationHistoryCell.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 07/11/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import UIKit

class TranscationHistoryCell: UITableViewCell {

    @IBOutlet weak var lblProduct: UILabel!
    
    @IBOutlet weak var lblEntryNo: UILabel!
    
    
    @IBOutlet weak var lblInsurer: UILabel!
    
    @IBOutlet weak var lblPremium: UILabel!
    
    
    @IBOutlet weak var lblntryDate: UILabel!
    
    
    @IBOutlet weak var lblInceptionDate: UILabel!
    
    
    @IBOutlet weak var lblTotalOD: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(transactionData : TransationHistoryData){
        
        lblProduct.text = transactionData.ProductName ?? ""
       
        lblEntryNo.text = transactionData.EntryNo ?? ""
        lblInsurer.text = transactionData.InsCompany ?? ""
        
        lblPremium.text = transactionData.Premium ?? ""
        lblntryDate.text = transactionData.EntryDate ?? ""
        
        lblInceptionDate.text = transactionData.InceptionDate ?? ""
        lblTotalOD.text = transactionData.Total_OD ?? ""
    }

}
