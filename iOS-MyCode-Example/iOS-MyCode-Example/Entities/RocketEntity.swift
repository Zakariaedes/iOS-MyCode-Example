//
//  RocketEntity.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

struct RocketEntity{
    
    private(set) var id  : String = ""
    private(set) var name: String = ""
    private(set) var type: String = ""
    
    init(id: String? = nil) {
        if let id = id {
            self.id = id
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
    }
    
}

extension RocketEntity: Decodable {
 
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
    }
    
}

extension RocketEntity {
    
    static func fetch(id: String) async throws -> RocketEntity {
        try await RequestHandler.shared.call(.getRocket(id: id))
    }
    
}
