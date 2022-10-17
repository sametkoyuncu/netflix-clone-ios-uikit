//
//  SearchResultsViewController.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 15.10.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel )
}

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = []
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}

// MARK: - collection view delegate methods
extension SearchResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = titles[indexPath.row]
        
        guard let titleName = model.original_title ?? model.original_name else {
            return
        }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName,
                                                                                      titleOverview: model.overview ?? "No content!",
                                                                                      youtubeVideo: videoElement, titleModel: model))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

// MARK: - collection view datasource methods
extension SearchResultsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = titles[indexPath.row]
        cell.configure(with: model.poster_path ?? "")
        
        return cell
    }
    
    
}
