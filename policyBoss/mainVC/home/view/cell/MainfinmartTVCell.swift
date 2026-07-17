//
//  MainfinmartTVCell.swift
//  MagicFinmart
//
//  Created by Ashwini on 13/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

class MainfinmartTVCell: UITableViewCell {

    @IBOutlet weak var inTView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellTextView: UITextView!
    @IBOutlet weak var celldetailTextLbl: UILabel!
    @IBOutlet weak var cellNewImage: UIImageView!
    @IBOutlet weak var cellNewImageConstant: NSLayoutConstraint!
    @IBOutlet weak var cellbtnShareProduct: UIButton!
    
    @IBOutlet weak var cellbtnInfoProduct: UIButton!
    
    @IBOutlet weak var cellImageShareProduct: UIImageView!
    @IBOutlet weak var cellImageInfoProduct: UIImageView!
    
    
    
    // We are Using closure for click listenre alternative is Protocal-Delegate and add Target
    
    
    var tapShareProd: ( () -> Void)? = nil
    
     var tapInfoProd: ( () -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cellImageInfoProduct.isUserInteractionEnabled = true
        cellImageInfoProduct.addGestureRecognizer(tapGestureRecognizer)
        
        
//        let tapGestureShareeRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageShareTapped(tapGestureShareeRecognizer:)))
//        cellImageShareProduct.isUserInteractionEnabled = true
//        cellImageShareProduct.addGestureRecognizer(tapGestureRecognizer)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnShareProductClick(_ sender: Any) {
        
        tapShareProd?()
    }
    
    
    @IBAction func btnInfomProductClick(_ sender: Any) {
        
        tapInfoProd?()
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        
          tapInfoProd?()
    }
    
    
//    @objc func ImageShareTapped(tapGestureShareeRecognizer: UITapGestureRecognizer){
//        
//        tapShareProd?()
//        
//    }
    
    
    
    
    //
    
    
    
   
    
    
    

}
