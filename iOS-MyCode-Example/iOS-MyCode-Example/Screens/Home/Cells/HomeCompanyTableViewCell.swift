//
//  HomeCompanyTableViewCell.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

final class HomeCompanyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "\(HomeCompanyTableViewCell.self)"
    
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            let offset: CGPoint = .init(x: 3.0, y: 10.0)
            $0.top.equalToSuperview().offset(offset.y)
            $0.bottom.equalToSuperview().offset(-offset.y)
            $0.leading.equalToSuperview().offset(offset.x)
            $0.trailing.equalToSuperview().offset(-offset.x)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(description: String) {
        descriptionLabel.text = description
    }
    
}
