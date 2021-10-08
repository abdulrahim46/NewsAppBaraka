//
//  SelfConfiguringCell .swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: Articles)
}
