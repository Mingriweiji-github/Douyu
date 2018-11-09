//
//  MainViewController.swift
//  Douyu
//
//  Created by Roc01 on 2018/11/8.
//  Copyright © 2018 Roc.iMac01. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyboard: "Home")
        addChildVC(storyboard: "Live")
        addChildVC(storyboard: "Follow")
        addChildVC(storyboard: "Profile")
    }
    
    private func addChildVC(storyboard: String) {
        let childVC = UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    

}
