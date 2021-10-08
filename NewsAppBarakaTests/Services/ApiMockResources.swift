//
//  ApiMockResources.swift
//  NewsAppBarakaTests
//
//  Created by Abdul Rahim on 08/10/21.
//

import Foundation
import Combine

@testable import NewsAppBaraka

struct ApiMockResources: DataProvider {
    
    /// mock func for get news
    func getNews() -> AnyPublisher<News, NetworkManager.APIError> {
        
        let featuredArt = [Articles(image: "desert", title: "SOMETHING NEW", description: "Calorie Counter App", author: "abc", url: "www.google.com"),
                           Articles(image: "desert", title: "SOMETHING NEW", description: "Calorie Counter App", author: "abc", url: "www.google.com"),
                           Articles(image: "desert", title: "SOMETHING NEW", description: "Calorie Counter App", author: "abc", url: "www.google.com")]
        
        let data = News(articles: featuredArt, type: "top")
        return Just(data)
            .setFailureType(to: NetworkManager.APIError.self)
            .eraseToAnyPublisher()
        
    }
    
    
}
