//
//  EnvironmentHandler.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

internal struct EnvironmentHandler {
    
    static var shared: EnvironmentHandler = .init()
    
    private let infoDictionary: [String: Any]? = Bundle.main.infoDictionary
    
    private(set) var baseURL: String = ""
    
    private enum EnvironmentPlistKey: String {
        case baseURL = "BaseURL"
    }
    
    private func get(key: EnvironmentPlistKey) -> String? {
        
        if let infoDictionary: [String: Any] = self.infoDictionary,
           let plistValue: String = infoDictionary[key.rawValue] as? String{
            return plistValue
        }
        
        return nil
        
    }
    
    mutating func initialize(){
        self.baseURL = self.get(key: .baseURL) ?? ""
    }
    
}
