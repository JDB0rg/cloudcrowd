//
//  MainTabBarController.swift
//  Clouds
//
//  Created by Jonah  on 7/28/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{

    let cloudImageController = CloudImageController()
    let cloudDataController = CloudDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        for navController in viewControllers! {
            if let navController = navController as? UINavigationController,
                let viewController = navController.viewControllers.first
                    as? Injectable {
                        viewController.inject(data: cloudDataController)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
