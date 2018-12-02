//
//  CarouselFlowLayout.swift
//  MicroInteractions
//
//  Created by Parveen Khatkar on 23/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

public class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    var currentCellIndex: Int = 0 {
        didSet {
            if currentCellIndex != oldValue, var parallax = collectionView?.cellForItem(at: IndexPath(item: oldValue, section: 0)) as? Parallax {
                parallax.isCentered = false;
            }
            
            if var parallax = collectionView?.cellForItem(at: IndexPath(item: currentCellIndex, section: 0)) as? Parallax {
                parallax.isCentered = true;
            }
        }
    }
    
    public var scale: CGFloat = 1;
    
    public override func prepare() {
        super.prepare();
        collectionView!.decelerationRate = UIScrollView.DecelerationRate.fast;
        
        let inset = collectionView!.bounds.size.width - itemSize.width;
        
        collectionView?.contentInset.left = inset / 2;
        collectionView?.contentInset.right = inset / 2;
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        
        var contentOffsetX: CGFloat = 0;
        if velocity.x.magnitude > 0
        {
            currentCellIndex += velocity.x > 0 ? 1 : -1;
            
            if currentCellIndex > 0 && currentCellIndex < collectionView.numberOfItems(inSection: 0) {
                contentOffsetX =  ((itemSize.width + minimumInteritemSpacing) * CGFloat(currentCellIndex)) - collectionView.contentInset.left;
                return CGPoint(x: contentOffsetX, y: proposedContentOffset.y);
            }
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        contentOffsetX = proposedContentOffset.x + offsetAdjustment;
        currentCellIndex = Int((contentOffsetX + collectionView.contentInset.left) / (itemSize.width + minimumInteritemSpacing));
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesArray = super.layoutAttributesForElements(in: rect);
        guard let collectionView = collectionView else { return attributesArray }
        
        let index = ((collectionView.contentOffset.x + collectionView.contentInset.left) / (itemSize.width + minimumInteritemSpacing));
            
        attributesArray?.forEach({ (attributes) in
            let delta = CGFloat(currentCellIndex) - index;
            var position = Position.center;
            
            if attributes.indexPath.item != currentCellIndex {
                position = attributes.indexPath.item < currentCellIndex ? .left : .right;

                let range = Range<CGFloat>(uncheckedBounds: (0, 1));
                let newRange = Range<CGFloat>(uncheckedBounds: (scale, 1));
                let normalizedDelta = delta.magnitude;
                let normalizedScale = remap(value: normalizedDelta, range: range, newRange: newRange);
                let directionSign: CGFloat = attributes.indexPath.item < currentCellIndex ? 1 : -1;

                let translation = (itemSize.width - (itemSize.width * normalizedScale)) / 2 * directionSign;
                attributes.transform = attributes.transform.translatedBy(x: translation, y: 0);
                attributes.transform = attributes.transform.scaledBy(x: normalizedScale, y: normalizedScale);
            } else {
                let range = Range<CGFloat>(uncheckedBounds: (0, 1));
                let newRange = Range<CGFloat>(uncheckedBounds: (scale, 1));
                let normalizedDelta = 1 - delta.magnitude;
                let normalizedScale = remap(value: normalizedDelta, range: range, newRange: newRange);
                let directionSign: CGFloat = delta < 0 ? 1 : -1;

                let translation = (itemSize.width - (itemSize.width * normalizedScale)) / 2 * directionSign;
                attributes.transform = attributes.transform.translatedBy(x: translation, y: 0);
                attributes.transform = attributes.transform.scaledBy(x: normalizedScale , y: normalizedScale);
            }
            
            if let parallax = collectionView.cellForItem(at: attributes.indexPath) as? Parallax {
                parallax.parallaxChanged(amount: delta, position: position);
            }
        })
        
        return attributesArray;
    }
    
    private func remap(value: CGFloat, range: Range<CGFloat>, newRange: Range<CGFloat>) -> CGFloat {
        return newRange.lowerBound + (newRange.upperBound - newRange.lowerBound) * (value - range.lowerBound) / (range.upperBound - range.lowerBound);
    }
}

public protocol Parallax {
    var isCentered: Bool {get set};
    func parallaxChanged(amount: CGFloat, position: Position);
    func moved();
}

public enum Position {
    case left
    case center
    case right
}
