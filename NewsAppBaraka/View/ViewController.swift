//
//  ViewController.swift
//  NewsAppBaraka
//
//  Created by Abdul Rahim on 07/10/21.
//

import UIKit
import Combine
import SafariServices

class ViewController: UIViewController {
    
    // MARK: - Properties & Views
    
    var anyCancelable = Set<AnyCancellable>()
    let viewModel = NewsViewModel()
    private var news: News?
    
    var collectionView: UICollectionView!
    //var dataSource: UICollectionViewDiffableDataSource<News, Articles>?
    
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK:- Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        fetchNews()
        setupCollectionView()
    }
    
    //MARK:- View Setup
    
    /// setup collectionview
    func setupCollectionView() {
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        /// Assigning data source and background color
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        ///tells the system we will define our own constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        /// Constraining the collection view to the 4 edges of the view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(TopSectionCollectionViewCell.self, forCellWithReuseIdentifier: TopSectionCollectionViewCell.reuseIdentifier)
        collectionView.register(BottomSectionCollectionViewCell.self, forCellWithReuseIdentifier: BottomSectionCollectionViewCell.reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    private func fetchNews() {
        viewModel.fetchNews()
        viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { news in
                self.collectionView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
            .store(in: &anyCancelable)
        
    }
    
    // MARK: - Collection View Helper Methods -
    /// In this section you can find all the layout related code
    
    /// Creates the appropriate UICollectionViewLayout for each section type
    private func makeLayout() -> UICollectionViewLayout {
        /// Constructs the UICollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch self.viewModel.sectionType(for: sectionIndex) {
            case .singleList:   return self.createSingleListSection()
            case .doubleList:   return self.createDoubleListSection()
            case .tripleList:   return self.createTripleListSection()
            }
        }
        
        /// Configure the Layout with interSectionSpacing
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    
    /// Creates the layout for the single styled sections
    private func createSingleListSection() -> NSCollectionLayoutSection {
        /// Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        /// Construct the Layout Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        /// Configuring the Layout Item
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        /// Defining the size of a group in this layout
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(250))
        /// Constructing the Layout Group
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        /// Constructing the Layout Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        /// Configuring the Layout Section
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    /// Creates a layout that shows 2 items per group and scrolls horizontally
    private func createDoubleListSection() -> NSCollectionLayoutSection {
        /// Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.5))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(165))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 2)
        layoutGroup.interItemSpacing = .fixed(8)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    
    /// Creates a layout that shows all new items inside a group and scrolls vertically
    private func createTripleListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 5,
                                                        bottom: 5,
                                                        trailing: 5)
        let layoutSectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [layoutSectionHeader]
        return section
    }
    
    /// Creates a Layout for the SectionHeader
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        /// Define size of Section Header
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                             heightDimension: .estimated(80))
        
        /// Construct Section Header Layout
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    deinit {
        print("viewcontroller instance clear from memory")
    }
    
    
}

//MARK:- Extension for collectionview datasource & delegate

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    /// Tells the UICollectionView how many sections are needed
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    /// Tells the UICollectionView how many items the requested sections needs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return viewModel.numberOfItems(for: section)
        }
    }
    
    /// Constructs and configures the item needed for the requested IndexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Checks what section type we should use for this indexPath so we use the right cells for that section
        switch viewModel.sectionType(for: indexPath.section) {
        case .singleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSectionCollectionViewCell.reuseIdentifier, for: indexPath) as? TopSectionCollectionViewCell else {
                fatalError("Could not dequeue topcell")
            }
            
            viewModel.configure(item: cell, for: indexPath)
            
            return cell
            
        case .doubleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomSectionCollectionViewCell.reuseIdentifier, for: indexPath) as? BottomSectionCollectionViewCell else {
                fatalError("Could not dequeue middle cell")
            }
            
            viewModel.configure(item: cell, for: indexPath)
            
            return cell
        case .tripleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomSectionCollectionViewCell.reuseIdentifier, for: indexPath) as? BottomSectionCollectionViewCell else {
                fatalError("Could not dequeue bottom cell")
            }
            
            viewModel.configure(item: cell, for: indexPath)
            
            return cell
        }
    }
    
    /// selecting the specific item inside the collectionview cell will open safariviewcontroller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let new = viewModel.topNews?[indexPath.row] else { return }
        SFSafariViewController.openWithSafariVC(url: URL(string:new.url ?? "")!, from: self)
    }
    
    ///  Section Headers for collectionview
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
            fatalError("Could not dequeue SectionHeader")
        }
        switch viewModel.sectionType(for: indexPath.section) {
        case .singleList:
            headerView.titleLabel.text = "Top 6 News"
            headerView.subtitleLabel.text = "Top section horizontal scroll"
        case .doubleList:
            headerView.titleLabel.text = "Breaking News"
            headerView.subtitleLabel.text = "Middle section horizontal scroll"
        default:
            headerView.titleLabel.text = "Top 100 News"
            headerView.subtitleLabel.text = "Bottom section vertical scroll"
        }
        return headerView
    }
    
}

