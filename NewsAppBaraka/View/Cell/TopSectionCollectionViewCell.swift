//
//  TopSectionCollectionViewCell.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import UIKit
import SDWebImage

class TopSectionCollectionViewCell: UICollectionViewCell, AppConfigurable {
    
    
    // MARK:- Properties & views
    
    static let reuseIdentifier: String = "TopSectionCell"
    
    let tagline = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// setup view for cell
    func setupView() {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel

        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue

        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label

        subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .secondaryLabel

        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        let stackView = UIStackView(arrangedSubviews: [separator, tagline, name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitle)
    }

    /// configure cell here
    func configure(with article: Articles) {
        name.text = article.title
        subtitle.text = article.description
        if let imageData = article.image {
            imageView.sd_setImage(with: URL(string: imageData),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .continueInBackground,
                                  completed: nil)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Not happening")
    }
}
