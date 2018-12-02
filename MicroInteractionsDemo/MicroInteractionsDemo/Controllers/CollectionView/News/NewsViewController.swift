//
//  NewsViewController.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 02/12/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News";
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationController?.navigationBar.shadowImage = UIImage();
        navigationController?.navigationBar.isTranslucent = false;
        
        let newsCollectionViewController = NewsCollectionViewController();
        addChild(newsCollectionViewController);
        newsCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        containerView.addSubview(newsCollectionViewController.view);
        newsCollectionViewController.view.constraintToFit(inContainerView: containerView);
        newsCollectionViewController.didMove(toParent: self);
    }
}
