//
//  LaunchEntity.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

struct LaunchEntity{
    
    private var id         : String       = ""
    private var dateTime   : Int          = 0
    
    private(set) var name  : String       = ""
    private(set) var rocket: RocketEntity = .init()
    private(set) var links : LaunchLinksEntity = .init()
    private(set) var wasSucceeded: Bool?
    
    private(set) var date: String = ""
    private(set) var time: String = ""
    
    private var pendingDaysCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "date_unix"
        case wasSucceeded = "success"
        
        case id
        case name
        case rocket
        case links
    }
    
    init(){}
    
    mutating func set(rocket: RocketEntity) {
        self.rocket = rocket
    }
    
    func getPendingDaysCount() -> Int {
        return pendingDaysCount
    }
    
}

extension LaunchEntity: Decodable {
 
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        dateTime = try values.decode(Int.self, forKey: .dateTime)
        rocket = .init(id: try values.decode(String.self, forKey: .rocket))
        links = try values.decode(LaunchLinksEntity.self, forKey: .links)
        wasSucceeded = try values.decodeIfPresent(Bool?.self, forKey: .wasSucceeded) ?? nil
        
        let currentCalendar: Calendar = Calendar.current
        let launchDate: Date = Date(timeIntervalSince1970: TimeInterval(dateTime))
        
        let dateComponents: DateComponents = currentCalendar.dateComponents(in: .current, from: launchDate)
        
        if  let day    = dateComponents.day,
            let month  = dateComponents.month,
            let year   = dateComponents.year,
            let hour   = dateComponents.hour,
            let minute = dateComponents.minute{
            date = "\(day)/\(month)/\(year)"
            time = "\(hour):\(minute)"
        }
        
        pendingDaysCount = currentCalendar.dateComponents([.day], from: launchDate, to: Date()).day ?? 0
        
    }
    
}

struct LaunchLinksEntity: Decodable {
    
    private(set) var patch        : LaunchPatchEntity?
    private(set) var wikipediaLink: String?
    private(set) var webcastLink  : String?
    
    enum CodingKeys: String, CodingKey {
        case wikipediaLink = "wikipedia"
        case webcastLink = "webcast"
        
        case patch
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patch = try values.decodeIfPresent(LaunchPatchEntity?.self, forKey: .patch) ?? nil
        wikipediaLink = try values.decodeIfPresent(String?.self, forKey: .wikipediaLink) ?? nil
        webcastLink = try values.decodeIfPresent(String?.self, forKey: .webcastLink) ?? nil
    }
    
}

struct LaunchPatchEntity: Decodable {
    
    private(set) var small: String?
    
    enum CodingKeys: String, CodingKey {
        case small
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String?.self, forKey: .small) ?? nil
    }
    
}
