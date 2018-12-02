//
//  NewsCollectionViewController.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 02/12/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit
import MicroInteractions

class NewsCollectionViewController: UICollectionViewController {
    
    let carouselFlowLayout = CarouselFlowLayout();
    
    var backgrounds = [UIImage]();
    
    init() {
        super.init(collectionViewLayout: carouselFlowLayout);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(ImageCollectionViewCell.self);
        
        collectionView.backgroundColor = .clear;
        
        carouselFlowLayout.scale = 0.66;
        carouselFlowLayout.scrollDirection = .horizontal;
        
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        
        backgrounds.append(UIImage(named: "my-hero-academia")!);
        backgrounds.append(UIImage(named: "naruto")!);
        backgrounds.append(UIImage(named: "attack-on-titan")!);
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        carouselFlowLayout.itemSize = CGSize(width: 276, height: collectionView.frame.height - 24);
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self), for: indexPath) as! ImageCollectionViewCell;
        
        // Configure the cell
        cell.imageView.image = backgrounds[indexPath.item % backgrounds.count];
        
        return cell
    }
}
