//
//  UIViewController+Extension.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import UIKit

extension UIViewController{
    
    static let LOADING_ACTIVITY_VIEW_TAG: Int = 12
    
    func showLoader(with color: UIColor = .gray) {
        
        view.subviews.forEach { $0.isHidden = true }
        
        let loaderViewContainer: UIView = {
            let view: UIView = .init()
            view.tag = UIViewController.LOADING_ACTIVITY_VIEW_TAG
            view.backgroundColor = .white
            return view
        }()
        
        let indicatorView: UIActivityIndicatorView = {
            let view: UIActivityIndicatorView = .init(style: .large)
            view.color = color
            view.startAnimating()
            return view
        }()
        
        loaderViewContainer.addSubview(indicatorView)
        view.addSubview(loaderViewContainer)
        
        loaderViewContainer.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    func hideLoader() {
        
        view.viewWithTag(UIViewController.LOADING_ACTIVITY_VIEW_TAG)?.removeFromSuperview()
        
        view.subviews.forEach { $0.isHidden = false }
        
    }
    
}
