//
//  DatePickerVC.swift
//  MagicFinmart
//
//  Created by Ashwini on 12/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import UIKit

protocol SelectedDateDelegate
{
    func getDateData(currDate: String, fromScreen: String)
    func getintData(indata:Int)
}

class DatePickerVC: UIViewController {
    
    var dateDelegate : SelectedDateDelegate?
    var fromScreen = ""
    var maximumDate = Date()

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--<set18YearValidation>--
        if(fromScreen == "fromlyfInsInput" || fromScreen == "fromEnrolPOSP" || fromScreen == "fromRegisterPage")
        {
            var components = DateComponents()
            components.year = -100
            let minDate = Calendar.current.date(byAdding: components, to: Date())
            components.year = -18
            let maxDate = Calendar.current.date(byAdding: components, to: Date())
           datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
        }
        else if(fromScreen == "crdtcardrbl")
        {
            var components = DateComponents()
            //            components.year = -100
            //            let minDate = Calendar.current.date(byAdding: components, to: Date())
            components.year = -23
            let maxDate = Calendar.current.date(byAdding: components, to: Date())
            //            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
        }
    }
    
    @IBAction func dateOkBtnCliked(_ sender: Any)
    {
        let dateFormatter = DateFormatter()
        if(fromScreen == "QuickLead")
        {
            dateFormatter.dateFormat = "MM-dd-yyyy"
        }
        else{
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }

        let curDate = dateFormatter.string(from: datePicker.date)
        print("curDate== ", curDate)
        let intDate = Int64(datePicker.date.timeIntervalSince1970*1000)
        print("intDate=",intDate)
        
        if(curDate != "")
        {
            self.dateDelegate?.getDateData(currDate: curDate, fromScreen: fromScreen)
            self.dateDelegate?.getintData(indata:Int(intDate))
        }
    
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func dateCancelBtnCliked(_ sender: Any)
    {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}

