//
//  AnimeViewController.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 24/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

class AnimeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Anime";
        navigationController?.navigationBar.prefersLargeTitles = true;
        navigationController?.navigationBar.shadowImage = UIImage();
        navigationController?.navigationBar.isTranslucent = false;
        
        let collectionViewController = AnimeCollectionViewController();
        addChild(collectionViewController);
        collectionViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        containerView.addSubview(collectionViewController.view);
        collectionViewController.view.constraintToFit(inContainerView: containerView);
        collectionViewController.didMove(toParent: self);
    }
}
