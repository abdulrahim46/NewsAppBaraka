//
//  NewsViewModel.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import Foundation
import UIKit
import Combine

class NewsViewModel {
    
    // MARK: - Properties
    
    @Published var topNews: [Articles]?
    @Published var news:  News?
    private var dataSource: [Section] = []
    private var anyCancelable = Set<AnyCancellable>()
    
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
        fetchNews()
        unsubscribe()
    }
    
    public func unsubscribe() -> Void {
            anyCancelable.forEach {
                $0.cancel()
            }
            anyCancelable.removeAll()
        }
    
    /// fetching news from server
    func fetchNews() {
        apiResource.getNews()
            .receive(on: DispatchQueue.main)
            .map{$0}
            .sink { completion in
                
                switch completion {
                
                case .finished:
                    print("Done")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { news in
                self.topNews = news.articles
                self.news = news
                self.createDataSource()
                
            }
            .store(in: &anyCancelable)
    }
    
    /// creating data sources for different sections
    func createDataSource() {
        let section1 = Section(id: 1, type: .singleList, title: nil, subtitle: nil, data: topNews ?? [])
        dataSource.append(section1)
        
        let section2 = Section(id: 2, type: .doubleList, title: nil, subtitle: nil, data: news?.articles ?? [])
        dataSource.append(section2)
        
        let section3 = Section(id: 3, type: .tripleList, title: nil, subtitle: nil, data: news?.articles ?? [])
        dataSource.append(section3)
    }
    
    
    // MARK: Collection View
    
    /// Returns the number of sections in the dataSource
    var numberOfSections: Int {
        return dataSource.count
    }
    
    /// Returns the number of items for the given section
    func numberOfItems(for sectionIndex: Int) -> Int {
        let section = dataSource[sectionIndex]
        return section.data.count
    }
    
    // MARK: Cells
    
    /// Configures the given item with the app appropriate for the given IndexPath
    func configure(item: AppConfigurable, for indexPath: IndexPath) {
        let section = dataSource[indexPath.section]
        if let app = section.data[indexPath.row] as? Articles {
            item.configure(with: app)
        } else {
            print("Error getting app for indexPath: \(indexPath)")
        }
    }
    
    /// Returns the SectionType for the given sectionIndex
    func sectionType(for sectionIndex: Int) -> SectionType {
        let section = dataSource[sectionIndex]
        return section.type
    }
}
