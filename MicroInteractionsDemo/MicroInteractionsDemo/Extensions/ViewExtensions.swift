//
//  ViewExtensions.swift
//  MicroInteractionsDemo
//
//  Created by Parveen Khatkar on 02/12/18.
//  Copyright © 2018 Codetrix Studio. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.cornerRadius = 16;
        clipsToBounds = false;
        layer.shadowRadius = 6;
        layer.shadowOffset = CGSize.zero;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = UIColor.black.cgColor;
    }
}
