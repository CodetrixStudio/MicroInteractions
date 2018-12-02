//
//  ImageCollectionViewCell.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 02/12/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addShadow();
        
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds = true;
    }

}
