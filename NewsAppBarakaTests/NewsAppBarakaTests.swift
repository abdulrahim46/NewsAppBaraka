//
//  NewsAppBarakaTests.swift
//  NewsAppBarakaTests
//
//  Created by Abdul Rahim on 07/10/21.
//

import XCTest
import Combine

@testable import NewsAppBaraka

class NewsAppBarakaTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    // test for news fetcher api
    func testLoadingDataForNews() {
        let mock = ApiMockResources()
        let fetcher = NewsViewModel(apiResource: mock)
        
        XCTAssertEqual(fetcher.news?.articles, nil, "starting with no data...")
        
        let promise = expectation(description: "loading 3 news data count...")
        fetcher.$news.sink{ (completion) in
            XCTFail()
        } receiveValue: { (news) in
            if news?.articles.count == 3 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 1)
        
    }
   
}
