//
//  HomeUIView.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

final class HomeUIView: UIView {
    
    let launchesTableView: UITableView = {
        let tableView: UITableView = .init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.separatorColor = .black
        tableView.separatorInset = .zero
        tableView.sectionFooterHeight = 0.0
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(launchesTableView)
        
        launchesTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
