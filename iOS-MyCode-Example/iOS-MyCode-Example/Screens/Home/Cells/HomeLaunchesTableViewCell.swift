//
//  HomeLaunchesTableViewCell.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit
import Kingfisher

final class HomeLaunchesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "\(HomeLaunchesTableViewCell.self)"
    
    private let patchImageView: UIImageView = {
        let image: UIImageView = .init()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let missionTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .lightGray
        label.text = "\("home_screen.mission".localized):"
        return label
    }()
    
    private let missionValueLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let dateTimeTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .lightGray
        label.text = "\("home_screen.datetime".localized):"
        return label
    }()
    
    private let dateTimeValueLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let rocketTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .lightGray
        label.text = "\("home_screen.rocket".localized):"
        return label
    }()
    
    private let rocketValueLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let daysTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .lightGray
        return label
    }()
    
    private let daysValueLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .darkGray
        return label
    }()
    
    private let launchStatusImageView: UIImageView = {
        let image: UIImageView = .init()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        patchImageView.image = nil
        launchStatusImageView.image = nil
    }
    
    private func setSubviews() {
        
        contentView.addSubviews(
            patchImageView,
            missionTitleLabel,
            missionValueLabel,
            dateTimeTitleLabel,
            dateTimeValueLabel,
            rocketTitleLabel,
            rocketValueLabel,
            daysTitleLabel,
            daysValueLabel,
            launchStatusImageView
        )
        
        let offset        : CGPoint = .init(x: 5.0, y: 20.0)
        let patchImageSize: CGFloat = 40.0
        let labelSpacing  : CGFloat = 5.0
        
        let patchImageSpacingArea: CGFloat = (offset.x * 2) + patchImageSize
        let widestTitleLabelWidth: CGFloat = getTheWidestTitleWidth() + patchImageSpacingArea + 2.0
        
        patchImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset.y)
            $0.leading.equalToSuperview().offset(offset.x)
            $0.width.height.equalTo(patchImageSize)
        }
        
        missionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(patchImageView)
            $0.bottom.equalTo(missionValueLabel)
            $0.leading.equalTo(patchImageView.snp.trailing).offset(offset.x)
            $0.trailing.equalTo(missionValueLabel.snp.leading)
        }
        
        missionValueLabel.snp.makeConstraints {
            $0.top.equalTo(missionTitleLabel)
            $0.leading.equalTo(widestTitleLabelWidth)
            $0.trailing.equalTo(launchStatusImageView.snp.leading).offset(-offset.x)
        }
        
        dateTimeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(missionTitleLabel.snp.bottom).offset(labelSpacing)
            $0.bottom.equalTo(dateTimeValueLabel)
            $0.leading.equalTo(missionTitleLabel)
            $0.trailing.equalTo(dateTimeValueLabel.snp.leading)
        }
        
        dateTimeValueLabel.snp.makeConstraints {
            $0.top.equalTo(dateTimeTitleLabel)
            $0.leading.equalTo(widestTitleLabelWidth)
            $0.trailing.equalTo(missionValueLabel)
        }
        
        rocketTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dateTimeTitleLabel.snp.bottom).offset(labelSpacing)
            $0.bottom.equalTo(rocketValueLabel)
            $0.leading.equalTo(missionTitleLabel)
            $0.trailing.equalTo(rocketValueLabel.snp.leading)
        }
        
        rocketValueLabel.snp.makeConstraints {
            $0.top.equalTo(rocketTitleLabel)
            $0.leading.equalTo(widestTitleLabelWidth)
            $0.trailing.equalTo(missionValueLabel)
        }
        
        daysTitleLabel.snp.makeConstraints {
            $0.top.equalTo(rocketTitleLabel.snp.bottom).offset(labelSpacing)
            $0.bottom.equalTo(daysValueLabel)
            $0.leading.equalTo(missionTitleLabel)
            $0.trailing.equalTo(daysValueLabel.snp.leading)
        }
        
        daysValueLabel.snp.makeConstraints {
            $0.top.equalTo(daysTitleLabel)
            $0.bottom.equalToSuperview().offset(-offset.y)
            $0.leading.equalTo(widestTitleLabelWidth)
            $0.trailing.equalTo(missionValueLabel)
        }
        
        launchStatusImageView.snp.makeConstraints {
            $0.top.equalTo(patchImageView)
            $0.trailing.equalToSuperview().offset(-offset.x)
            $0.width.height.equalTo(patchImageSize)
        }
        
    }
    
    /*
     * This function calculates the widest title Label,
     * so all other values labels can be positioned into one leading line,
     */
    
    private func getTheWidestTitleWidth() -> CGFloat {
        
        return max(missionTitleLabel.intrinsicContentSize.width, dateTimeTitleLabel.intrinsicContentSize.width, rocketTitleLabel.intrinsicContentSize.width, daysTitleLabel.intrinsicContentSize.width)
        
    }
    
    func updateCellWith(launch: LaunchEntity) {
        
        missionValueLabel.text  = launch.name
        dateTimeValueLabel.text = .init(format: "home_screen.launch_datetime".localized, launch.date, launch.time)
        launchStatusImageView.image = .init(systemName: launch.wasSucceeded == nil ? "clock" : launch.wasSucceeded! ? "checkmark" : "xmark")
        
        let pendingDaysCount: Int = launch.getPendingDaysCount()
        daysTitleLabel.text = "\((pendingDaysCount > 0 ? "home_screen.days_since_now" : "home_screen.days_from_now").localized):"
        daysValueLabel.text = "\(pendingDaysCount)"
        
        if launch.rocket.name.isEmpty && launch.rocket.type.isEmpty{
            rocketValueLabel.text = "home_screen.n_a".localized
        } else {
            rocketValueLabel.text = .init(format: "home_screen.rocket_info".localized, launch.rocket.name, launch.rocket.type)
        }
        
        if let patchURL: String = launch.links.patch?.small,
           let url: URL = .init(string: patchURL) {
            patchImageView.kf.setImage(with: url)
        }
        
        setSubviews()
        
    }
    
}
