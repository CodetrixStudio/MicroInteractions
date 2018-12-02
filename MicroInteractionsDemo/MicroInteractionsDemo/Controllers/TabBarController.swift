//
//  TabBarController.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 23/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//`

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            UINavigationController(rootViewController: AnimeViewController())
        ]
        
        tabBar.items?[0].image = UIImage(named: "icons8-popcorn-25");
        tabBar.items?[0].title = "Movies";
    }
}
