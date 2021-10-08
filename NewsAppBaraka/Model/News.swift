//
//  News.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import Foundation

/// News model
struct News: Encodable, Decodable, Hashable {
    let articles: [Articles]
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case type = "type"
    }
}

/// Articles model
struct Articles: SectionData, Encodable, Decodable, Hashable {
    let image: String?
    let title: String?
    let description: String?
    let author: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "urlToImage"
        case title = "title"
        case description = "description"
        case author = "author"
        case url = "url"
    }
}
