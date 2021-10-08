//
//  Section.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 08/10/21.
//

import Foundation

/*
The Section type will decide what layout the UICollectionView will use for that section
 */
enum SectionType: Int, CaseIterable {
    case singleList     // top list
    case doubleList     // middle list
    case tripleList     // bottom list
}

// Descibes the info needed for a Section
struct Section {
    let id: Int
    let type: SectionType
    let title: String?
    let subtitle: String?
    let data: [SectionData]
}

// Token protocol to avoid using "Any" in the dataSource, as we are working with App and Category
protocol SectionData { }
