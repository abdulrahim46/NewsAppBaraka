//
//  News.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import Foundation

struct News: Encodable, Decodable, Hashable {
//    static func == (lhs: News, rhs: News) -> Bool {
//        return lhs == rhs
//    }
    
    let articles: [Articles]
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
        case type = "type"
    }
}

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
