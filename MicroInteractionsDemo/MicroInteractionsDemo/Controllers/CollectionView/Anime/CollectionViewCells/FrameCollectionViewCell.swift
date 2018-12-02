//
//  FrameCollectionViewCell.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 24/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit
import MicroInteractions

class FrameCollectionViewCell: UICollectionViewCell, Parallax {
    
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var propertyAnimator: UIViewPropertyAnimator!
    
    var isCentered = false {
        didSet {
            if isCentered && oldValue == false {
                didBecomeCentered();
            } else {
                didBecomeUncentered();
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setShadow(posterImageView.layer);
        
        backgroundContainerView.clipsToBounds = true;
        backgroundContainerView.layer.cornerRadius = 10;
        
        propertyAnimator = UIViewPropertyAnimator(duration: 5, curve: .easeOut, animations: animations);
        propertyAnimator.pausesOnCompletion = true;
    }
    
    private func setShadow(_ layer: CALayer) {
        layer.cornerRadius = 16;
        clipsToBounds = false;
        layer.shadowRadius = 6;
        layer.shadowOffset = CGSize.zero;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = UIColor.black.cgColor;
    }
    
    deinit {
        propertyAnimator.stopAnimation(true);
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        propertyAnimator.stopAnimation(true);
        backgroundImageView.transform = CGAffineTransform.identity;
        propertyAnimator = UIViewPropertyAnimator(duration: 5, curve: .easeOut, animations: animations);
        propertyAnimator.pausesOnCompletion = true;
        
    }
    // MARK: Parallax
    
    func parallaxChanged(amount: CGFloat, position: Position) {
        print(String(format: "%@: %f", isCentered ? "true" : "false", amount));
//        propertyAnimator.fractionComplete = 1 - amount.magnitude;
        var amount = amount;
        switch position {
        case .left:
            amount = 1 - amount.magnitude;
            break;
        case .center:
            amount *= -1;
            break;
        case .right:
            amount = (1 - amount.magnitude) * -1;
            break;
        }
        
        let translation = amount * frame.size.width * 0.7;
        backgroundImageView.superview?.transform = CGAffineTransform.identity.translatedBy(x: translation, y: 0);
    }
    
    func moved() {
    }
    
    private func didBecomeCentered() {
        propertyAnimator.isReversed = false;
        propertyAnimator.pauseAnimation();
        propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 1.5);
    }
    
    private func didBecomeUncentered() {
        propertyAnimator.isReversed = true;
        propertyAnimator.pauseAnimation();
        propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.05);
    }
    
    private func animations() {
        self.backgroundImageView.transform = self.backgroundImageView.transform.scaledBy(x: 1.15, y: 1.15);
    }
}
