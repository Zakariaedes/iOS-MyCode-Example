//
//  CompanyEntity.swift.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import Foundation

struct CompanyEntity{
    
    private var id             : String = ""
    private var name           : String = ""
    private var founderName    : String = ""
    private var foundedYear    : Int    = 0
    private var employeesNumber: Int    = 0
    private var launchSites    : Int    = 0
    private var valuation      : Double = 0
    
    enum CodingKeys: String, CodingKey {
        case founderName = "founder"
        case foundedYear = "founded"
        case employeesNumber = "employees"
        case launchSites = "launch_sites"
        
        case id
        case name
        case valuation
    }
    
    init(){}
    
    func getFullDescription() -> String? {
        return id.isEmpty ? nil : String(format: "home_screen.company_description".localized, name, founderName, "\(foundedYear)", "\(employeesNumber)", "\(launchSites)", "\(valuation.stringWithoutZeroFraction)")
    }
    
}

extension CompanyEntity: Decodable {
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        founderName = try values.decode(String.self, forKey: .founderName)
        foundedYear = try values.decode(Int.self, forKey: .foundedYear)
        employeesNumber = try values.decode(Int.self, forKey: .employeesNumber)
        launchSites = try values.decode(Int.self, forKey: .launchSites)
        valuation = try values.decode(Double.self, forKey: .valuation)
    }
    
}

extension CompanyEntity {
    
    static func fetch() async throws -> CompanyEntity {
        try await RequestHandler.shared.call(.getCompanyInfo)
    }
    
}
