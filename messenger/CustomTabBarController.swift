//
//  CustomTabBarController.swift
//  messenger
//
//  Created by C4Q on 12/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        let friendController = FriendController.init(collectionViewLayout: layout)
        let recentMessageNavController = UINavigationController(rootViewController: friendController)
        recentMessageNavController.tabBarItem.title = "Recent"
        recentMessageNavController.tabBarItem.image = UIImage.init(named: "recent")
        let settingVC = UIViewController()
        let settingNarController = UINavigationController(rootViewController: settingVC)
        settingNarController.tabBarItem.image = UIImage.init(named: "setting")
        viewControllers = [recentMessageNavController, settingNarController]
    }

}
