//
//  getmpsTnCVC.swift
//  MagicFinmart
//
//  Created by Admin on 19/04/19.
//  Copyright © 2019 Ashwini. All rights reserved.
//

import UIKit

class getmpsTnCVC: UIViewController {

    @IBOutlet var tncTextView: UITextView!
    
    var A = "The Magic Platinum Subscription (MPS) is an offer being extended by Datacomp Web Technologies (India) Pvt. Ltd. (DWTIPL), to its customers who have downloaded and registered themselves as the Finmart Business Associates (FBA) of DWTIPL in the PolicyBoss Mobile App."
    
    var B = "Your use of the applications provided under the MPS scheme is subject to your acceptance of the “End User Licence Agreement (EULA)” of the respective application."
    
    var C = "The MPS offer is being extended as a welcome gesture by DWTIPL to its FBA. The gesture is being extended on the good faith that the FBA shall use the PolicyBoss Platform to generate business through the PolicyBoss Principal Service partners."
    
    var D = "DWTIPL is not bound / obligated to extended this offer indefinitely. DWTIPL reserves the right to withdraw the offer any time without any prior notice. DWTIPL also, at its sole discretion, decline the MPS offer to any FBA, without assigning any reason thereof to the FBA."
    
    var E = "The amount paid by you for MPS is strictly not refundable under any circumstances. Once the MPS offer is availed the amount paid by you shall be non-refundable. However, if due to any reason, if the amount is paid by you and the MPS is not activated within 7 working days, then, DWTIPL shall refund the entire amount paid by you for MPS without any penalty / interest."
    
    var F = "DWTIPL reserves the right to withdraw / modify the offer, its scope and pricing at any time without any prior notice. Those who have already availed the MPS shall not be impacted by the amendments within the validity of their subscription"
    
    var tncstringArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tncstringArray = [A,B,C,D,E,F]
        
        var fullString = ""
        
        for string: String in tncstringArray
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n\n"
            
            fullString = fullString + formattedString
        }
        
        tncTextView.text = fullString
   
    }
    

    @IBAction func bckcloseBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    

}


