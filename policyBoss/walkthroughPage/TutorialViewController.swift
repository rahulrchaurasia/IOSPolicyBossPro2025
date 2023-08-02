//
//  TutorialViewController.swift
//  MagicFinmart
//
//  Created by iOS Developer on 22/07/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit
import TTGSnackbar
import Alamofire

class TutorialViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebEngageAnaytics.shared.navigatingToScreen(AnalyticScreenName.WelcomeScreen)

        if(Core.shared.isVerifyInstall()){
            self.getDeviceDetails()
            
            Core.shared.setVerifyInstall()
        }
     
        
        setData()

        pageControl.addTarget(self, action: Selector("didChangePageControlValue"), for: .valueChanged)
        
        
    }
    
    //////////////////////  Method For Orientation   ////////////////////////////
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    //////////////////////////////////////////////////////////////////////
    func setData(){
        
        
        let borderColr = UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1)
        self.btnNext.layer.cornerRadius=2.0;
        self.btnNext.layer.borderWidth=2.0;
        self.btnNext.layer.borderColor=borderColr.cgColor;
       
        self.btnNext.setTitleColor(UIColor.init(red: 0/225.0, green: 125/225.0, blue: 213/225.0, alpha: 1), for: UIControl.State.normal)

        
         btnNext.tag = 0
         btnNext.tag = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
   
    func moveToEulaPage(){
        
    //   let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        
        let eulaVC = self.storyboard?.instantiateViewController(withIdentifier: "EulaVC") as!  EulaVC
        eulaVC.modalPresentationStyle = .fullScreen
        self.present(eulaVC, animated: false)
   
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        
        if( btnNext.tag == 1){
          moveToEulaPage()
        }else{
            tutorialPageViewController?.scrollToNextViewController()
        }
    }
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    @IBAction func didTapAlreadyAccountButton(_ sender: Any) {
        
               moveToEulaPage()
        
    }
    
    
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
        
        // print("COUNT",count)
        
        //  btnNext.setTitle("New Title", for: .normal)
    }
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        //  print("index",index)
        
        if(index == 4){
            
            btnNext.setTitle("GET STARTED", for: .normal)
            btnNext.tag = 1
        }else{
            
            btnNext.setTitle("NEXT", for: .normal)
            btnNext.tag = 0
        }
        
    }
    
    
    func getDeviceDetails(){
        
        if Connectivity.isConnectedToInternet()
        {
           
            
            let POSPNo = UserDefaults.standard.string(forKey: "POSPNo") as AnyObject
            
            let parameter  :[String: AnyObject] = [
                
                "ss_id": POSPNo as AnyObject,
                "device_id": getDeviceID() as AnyObject,
                "device_name": getDeviceName() as AnyObject,
                "os_detail": getDeviceOS() as AnyObject,
                "action_type": "install" as AnyObject,
                "device_info" : "" as AnyObject
                
            ]
            let endUrl = "/app_visitor/save_device_details"
            let url =  FinmartRestClient.baseURLROOT  + endUrl
    
            print("urlRequest= ",url)
            print("parameter= ",parameter)
            Alamofire.request(url, method: .post, parameters: parameter,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let obj = try decoder.decode(DeviceDetailModel.self, from: data)
                        
                        print("response= ",obj)
                        
                        
                    } catch let error {
                        print(error)
                       
                    }
                    
                    
                case .failure(let error):
                    print(error)
                   
                    
                }
            })
            
        }
        
    }
  
    
}

