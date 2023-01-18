//
//  HomeCustomFilterView.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 3/9/2022.
//

import UIKit

final class HomeCustomFilterView: UIViewController {
    
    private let containerView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.backgroundColor = .white
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 10.0, trailing: 0)
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .violetColor
        label.textAlignment = .center
        label.text = "home_screen.filter_view.title".localized
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let separatorView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .whiteVioletColor
        return view
    }()
    
    private let stepperTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .gray
        label.text = "\("home_screen.filter_view.year".localized):"
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    private let stepperView: HomeCustomStepperView = .init()
    
    private let sortTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .gray
        label.text = "\("home_screen.filter_view.sort".localized):"
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    private let sortSegmentControl: UISegmentedControl = {
        let segmentControl: UISegmentedControl = .init(items: ["home_screen.filter_view.asc".localized, "home_screen.filter_view.desc".localized])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.violetColor]
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        return segmentControl
    }()
    
    private let applyButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("home_screen.filter_view.apply".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .medium)
        button.backgroundColor = .violetColor
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    private let resetButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("home_screen.filter_view.reset".localized, for: .normal)
        button.setTitleColor(.violetColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .medium)
        button.backgroundColor = .whiteVioletColor
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    private var delegate: FilterToHomeViewProtocol?
    private var selectedYear: UInt?
    private var sortingIndex: Int?
    
    required init(selectedYear: UInt?, sortingIndex: Int?, delegate: FilterToHomeViewProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.selectedYear = selectedYear
        self.sortingIndex = sortingIndex
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(containerView)
        
        stepperView.currentNumber = selectedYear ?? stepperView.currentNumber
        sortSegmentControl.selectedSegmentIndex = sortingIndex ?? -1
        
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
        }
        
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(separatorView)
        
        //SETTING EACH TITLE AND ITS VIEW INSIDE HORIZONTAL STACK VIEW
        for container in [[stepperTitleLabel, stepperView], [sortTitleLabel, sortSegmentControl], [applyButton, resetButton]] {
            
            let stackView: UIStackView = .init()
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.directionalLayoutMargins = .init(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0)
            
            for view in container { stackView.addArrangedSubview(view) }
            
            containerView.addArrangedSubview(stackView)
            
        }
        
        let buttonsStackView: UIStackView = applyButton.superview as! UIStackView
        buttonsStackView.directionalLayoutMargins = .init(top: 20.0, leading: 10.0, bottom: 0, trailing: 10.0)
        buttonsStackView.spacing = 10.0
        buttonsStackView.distribution = .fillEqually
        
        applyButton.addTarget(self, action: #selector(onFilterItemsChanged(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(onFilterItemsChanged(_:)), for: .touchUpInside)
        
    }
    
    @objc
    private func onFilterItemsChanged(_ button: UIButton) {
        
        if button == applyButton {
            delegate?.onFilterItemsChanged(year: stepperView.currentNumber, sortIndex: sortSegmentControl.selectedSegmentIndex)
        } else {
            delegate?.onFilterItemsChanged(year: nil, sortIndex: nil)
        }
        
        dismiss(animated: true)
        
    }
    
}
