//
//  MainTabBarController.swift
//  Clouds
//
//  Created by Jonah  on 7/28/20.
//  Copyright © 2020 EmPact. All rights reserved.
//

import UIKit

protocol Injectable: class {
  func inject(data: CloudDataController)
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate{

    let cloudImageController = CloudImageController()
     let cloudDataController = CloudDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    private func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) {
        guard let identifyView = viewController as? CloudHomeViewController else {
            fatalError("Wrong view controller type")
        }
        //identifyView.cloudDataController = cloudDataController
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
