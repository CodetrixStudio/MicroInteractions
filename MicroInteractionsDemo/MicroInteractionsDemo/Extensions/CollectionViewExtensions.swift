//
//  CollectionViewExtensions.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 24/11/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String
    {
        let className = String(describing: self);
        return className;
    }
}

extension UICollectionView {
    func register(_ cellClass: UICollectionViewCell.Type) {
        let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil);
        self.register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier);
    }
}

extension UIView {
    func constraintToFit(inContainerView containerView: UIView, inset: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false;
        topAnchor.constraint(equalTo: containerView.topAnchor, constant: inset.top).isActive = true;
        rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: inset.right).isActive = true;
        bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: inset.bottom).isActive = true;
        leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: inset.left).isActive = true;
    }
}
