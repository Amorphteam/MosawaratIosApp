//
//  Book.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/12/22.
//

import Foundation
import SwiftUI
import CoreLocation


import Foundation

struct Posts: Hashable, Codable {
    enum CodingKeys: CodingKey{
        case posts
    }
    
    var posts: [Book]
}

struct Book: Hashable, Codable, Identifiable {
    enum CodingKeys: CodingKey {
        
        case post_id
        case post_name
        case post_categories
        case post_tags
        case details
        case images
    }
    
    var id = UUID()
    var post_id: Int
    var post_name: String
    var post_categories: [PostCategory]
    let post_tags: [PostTags]
    let details: Details
    let images: [Images]
}


struct PostCategory:Hashable, Codable {
    enum CodingKeys: CodingKey {
        case id
        case value
    }

    let id: Int
    let value: String
}


struct Details : Hashable,Codable {
    enum CodingKeys: CodingKey {
        case author_name
        case writer_name
        case file_name
        case page_count
        case id_number
        case source
        case font_type
        case category
        case writing_date
        case note1
        case note2
        case note3
        case note4
        case note5
        case note6
    }

    let author_name, writer_name, file_name, page_count: String
    let id_number, source, font_type, category: String
    let writing_date, note1, note2, note3: String
    let note4, note5, note6: String
}

// MARK: - Image
struct Images : Hashable,Codable{
    enum CodingKeys: CodingKey {
        case name
        case image_url
        case thumbnail_url
    }
    
    let name: String
    let image_url: String
    let thumbnail_url: String
    
//    var image: Image{
//        Image(image_url)
//    }
    
}




struct PostTags: Hashable,Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }

    let id: Int
    let name: String
}
