//
//  DataProvider.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 08/10/21.
//

import Foundation
import Combine

protocol DataProvider {
    func getNews() -> AnyPublisher<News, NetworkManager.APIError>
}
