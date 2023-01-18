//
//  UIView+Extension.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
}
