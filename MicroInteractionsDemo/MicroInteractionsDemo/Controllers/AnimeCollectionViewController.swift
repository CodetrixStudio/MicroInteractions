//
//  AnimeCollectionViewController.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 23/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit
import MicroInteractions

class AnimeCollectionViewController: UICollectionViewController {
    let carouselFlowLayout = CarouselFlowLayout();
    
    var backgrounds = [UIImage]();
    var posters = [UIImage]();
    
    init() {
        super.init(collectionViewLayout: carouselFlowLayout);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(FrameCollectionViewCell.self);

        collectionView.backgroundColor = .clear;
        
        carouselFlowLayout.scrollDirection = .horizontal;
        
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        
        backgrounds.append(UIImage(named: "my-hero-academia")!);
        posters.append(UIImage(named: "my-hero-academia-poster")!);
        
        backgrounds.append(UIImage(named: "naruto")!);
        posters.append(UIImage(named: "naruto-poster")!);
        
        backgrounds.append(UIImage(named: "attack-on-titan")!);
        posters.append(UIImage(named: "attack-on-titan-poster")!);
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        carouselFlowLayout.itemSize = CGSize(width: 345, height: collectionView.frame.height - 32);
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FrameCollectionViewCell.self), for: indexPath) as! FrameCollectionViewCell;
    
        // Configure the cell
        cell.backgroundImageView.image = backgrounds[indexPath.item % posters.count];
        cell.posterImageView.image = posters[indexPath.item % posters.count];
        cell.titleLabel.text = ["My Hero Academia", "Naruto", "Attack on Titan"][indexPath.item % posters.count];
    
        return cell
    }
}
