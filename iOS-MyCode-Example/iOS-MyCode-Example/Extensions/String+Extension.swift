//
//  String+Extension.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import Foundation


extension String{
    
    var localized: String{
        return NSLocalizedString(self, comment: self)
    }
    
}
