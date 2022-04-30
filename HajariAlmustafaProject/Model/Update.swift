//
//  Update.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/29/22.
//

import Foundation

struct Update: Hashable, Codable, Identifiable {
    enum CodingKeys: CodingKey {
        
        case status
        case statusCode
        case date
        
    }
    
    var id = UUID()
    let status: Bool
    let statusCode: Int
    let date: String
}
