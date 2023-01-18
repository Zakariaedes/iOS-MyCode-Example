//
//  UITableView+Extension.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import UIKit

extension UITableView {
    
    func showLoadingFooterView(){
        
        let containerView: UIView = {
            let view: UIView = .init(frame: .init(x: 0, y: 0, width: self.contentSize.width, height: 40.0))
            view.backgroundColor = .white
            return view
        }()
        
        let indicatorView: UIActivityIndicatorView = {
            let size: CGFloat = 20.0
            let view: UIActivityIndicatorView = .init(
                frame: .init(
                    x: (containerView.frame.width / 2) - (size / 2),
                    y: (containerView.frame.height / 2) - (size / 2),
                    width: size,
                    height: size
                )
            )
            view.style = .medium
            view.color = .gray
            view.startAnimating()
            return view
        }()
        
        containerView.addSubview(indicatorView)
        
        self.tableFooterView = containerView
        
    }
    
}
