//
//  HomeCustomStepperView.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 3/9/2022.
//

import UIKit

final class HomeCustomStepperView: UIStackView {
    
    private let minusButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("-", for: .normal)
        return button
    }()
    
    private let numberLabel: UILabel = {
        let label: UILabel = .init()
        label.textColor = .violetColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    private let plusButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle("+", for: .normal)
        return button
    }()
    
    private let stepperButtonsSize: CGFloat = 30.0
    
    var currentNumber: UInt = 0{
        didSet {
            numberLabel.text = "\(currentNumber)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let _spacing   : CGFloat = 10.0
        let halfSpacing: CGFloat = _spacing * 0.5
        let height     : CGFloat = stepperButtonsSize + _spacing
        
        spacing = _spacing
        backgroundColor = .white
        layer.cornerRadius = height / 2
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: halfSpacing, leading: 0, bottom: halfSpacing, trailing: 0)
        
        addArrangedSubview(minusButton)
        addArrangedSubview(numberLabel)
        addArrangedSubview(plusButton)
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        currentNumber    = UInt(Calendar.current.dateComponents([.year], from: Date()).year ?? 2022)
        numberLabel.text = "\(currentNumber)"
        
        transformButtons()
        
        minusButton.addTarget(self, action: #selector(onTapStepperButton(_:)), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(onTapStepperButton(_:)), for: .touchUpInside)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func transformButtons() {
        
        for button in [minusButton, plusButton] {
            button.backgroundColor = .whiteVioletColor
            button.setTitleColor(.violetColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.layer.cornerRadius = stepperButtonsSize * 0.5
            button.snp.makeConstraints {
                $0.width.height.equalTo(stepperButtonsSize)
            }
        }
        
    }
    
    @objc
    private func onTapStepperButton(_ button: UIButton) {
        
        if currentNumber == 1{
            return
        }
        
        if button == minusButton {
            currentNumber -= 1
        } else {
            currentNumber += 1
        }
        
    }
    
}
