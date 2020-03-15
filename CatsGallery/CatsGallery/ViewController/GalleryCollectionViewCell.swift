//
//  GalleryCollectionViewCell.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 13/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import UIKit
import Alamofire

class GalleryCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var progressIndicator: UIActivityIndicatorView?
    weak var photosManager: PhotoManager?
    var request: Request?
    var photoUrl: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupProgress()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        imageView?.layer.cornerRadius = 22
        imageView?.backgroundColor = .black
        
        contentView.addSubview(imageView!)
        
        imageView?.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView?.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView?.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupProgress() {
        progressIndicator = UIActivityIndicatorView(frame: bounds)
        progressIndicator?.hidesWhenStopped = true
        
        contentView.addSubview(progressIndicator!)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }

    func configure(with photoUrl: String, photosManager: PhotoManager) {
        self.photoUrl = photoUrl
        self.photosManager = photosManager
        reset()
        loadImage()
    }

    func reset() {
        imageView?.image = nil
        request?.cancel()
    }

    func loadImage() {
        if let image = photosManager?.cachedImage(for: photoUrl) {
            populate(with: image)
            return
        }
        downloadImage()
    }

    func downloadImage() {
        progressIndicator?.startAnimating()
        request = photosManager?.retrieveImage(for: photoUrl) { image in
            self.populate(with: image)
        }
    }

    func populate(with image: UIImage) {
        progressIndicator?.stopAnimating()
        imageView?.image = image
    }
}
