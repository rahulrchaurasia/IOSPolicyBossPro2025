//
//  HomeTabBar.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/22.
//  Copyright © 2022 policyBoss. All rights reserved.
//

import UIKit

class HomeTabBar:  UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        // Do any additional setup after loading the view.
    }
    

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       // print("Selected Tabar")
       
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
        if viewController.isKind(of: MenuTabVC.self) {
//             let vc =  TabTwoViewController()
//             vc.modalPresentationStyle = .overFullScreen
//             self.present(vc, animated: true, completion: nil)
//             return false
            
            showBottomSheetDialog()
            return false
          }
          return true
       
    }
    
    func showBottomSheetDialog(){
        
        
        /*****************************************************************************************/
         //       BottomSheet Dialog
        /*****************************************************************************************/
        
        //let navigationController = UINavigationController(rootViewController: UIViewController());

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier:  "MenuBottomSheetVC") as? MenuBottomSheetVC {
            
            if #available(iOS 15.0, *) {
                if let sheet = vc.sheetPresentationController{
                    sheet.detents = [.medium(), .large()]    // Sheetstyle
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false //Inside Scrolling
                    sheet.prefersGrabberVisible = true  // Grab Button
                    sheet.preferredCornerRadius = 32

                    sheet.prefersEdgeAttachedInCompactHeight = true
                    sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                }
            } 
         
            
           present(vc, animated: true)
        }
        
    }
   
   

}
