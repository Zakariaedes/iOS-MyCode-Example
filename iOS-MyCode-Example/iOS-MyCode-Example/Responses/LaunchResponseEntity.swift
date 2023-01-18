//
//  LaunchResponseEntity.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

struct LaunchResponseEntity: Decodable {
    
    var launches: [LaunchEntity] = []
    private(set) var totalPages: Int = 1
    private(set) var currentPage: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case launches = "docs"
        case currentPage = "page"
        
        case totalPages
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        launches = try values.decode([LaunchEntity].self, forKey: .launches)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        currentPage = try values.decode(Int.self, forKey: .currentPage)
    }
    
    mutating func replace(with launchResponseEntity: LaunchResponseEntity) {
        self.launches.append(contentsOf: launchResponseEntity.launches)
        self.totalPages = launchResponseEntity.totalPages
        self.currentPage = launchResponseEntity.currentPage
    }
    
    mutating func setCurrentPage(with newCurrentPage: Int) {
        currentPage = newCurrentPage
        totalPages = 1
    }
    
    mutating func getNextPage() -> Int{
        currentPage += 1
        return currentPage
    }
    
}

extension LaunchResponseEntity {
    
    static func fetch(page: Int, year: UInt?, sortIndex: Int?) async throws -> LaunchResponseEntity {
        try await RequestHandler.shared.call(.getLaunches(page: page, year: year, sortIndex: sortIndex))
    }
    
}
