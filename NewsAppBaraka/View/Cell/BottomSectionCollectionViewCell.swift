//
//  BottomSectionCollectionViewCell.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import UIKit

class BottomSectionCollectionViewCell: UICollectionViewCell, AppConfigurable {
    static let reuseIdentifier: String = "BottomTableCell"

    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    let authorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
       setup()
    }
    
    private func setup() {
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerTextStackView = UIStackView(arrangedSubviews: [name,
                                                                subtitle])
        innerTextStackView.axis = .vertical
        
        let innerButtonStackView = UIStackView(arrangedSubviews: [authorLabel])
        innerButtonStackView.axis = .horizontal
        innerButtonStackView.spacing = 15
        innerButtonStackView.alignment = .leading
        innerButtonStackView.distribution = .fillProportionally
        
        let innerStackView = UIStackView(arrangedSubviews: [innerTextStackView,
                                                            innerButtonStackView])
        innerStackView.axis = .vertical
        innerStackView.spacing = 10
        innerStackView.alignment = .leading
        innerStackView.distribution = .fillProportionally
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        outerStackView.distribution = .fillProportionally
        
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            authorLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75)
        ])
        
        style()
    }
    
    private func style() {
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.sizeThatFits(CGSize(width: 10.0, height: 10.0))
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.sizeThatFits(CGSize(width: 8.0, height: 8.0))
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.sizeThatFits(CGSize(width: 8.0, height: 8.0))
        authorLabel.textColor = .systemBlue
    }

    func configure(with article: Articles) {
        name.text = article.title
        subtitle.text = article.description
        authorLabel.text = article.author
        if let imageData = article.image {
            imageView.sd_setImage(with: URL(string: imageData),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .continueInBackground,
                                  completed: nil)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Just… no")
    }
}
