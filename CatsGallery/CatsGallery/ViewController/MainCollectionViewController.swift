//
//  MainCollectionViewController.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 12/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "photoCell"    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var gallery: [GalleryData] = []
    let photoManager = PhotoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = CollectionPresenter()
        presenter.delegate = self
        presenter.getImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView!.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell                
        
        if let list = gallery[indexPath.row].images, let link = list.first?.link {
            cell.configure(with: link, photosManager: photoManager)
        }
                
        return cell
    }

}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension MainCollectionViewController: CollectionDelegate {
    
    func refreshGallery(data: [GalleryData]) {
        self.gallery = data
        self.collectionView.reloadData()
    }
    
    func showErrorAlert(error: String) {
        print(error)
    }
    
    
}
