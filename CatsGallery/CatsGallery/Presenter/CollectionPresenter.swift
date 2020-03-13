//
//  CollectionPresenter.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 13/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

protocol CollectionDelegate {
    func refreshGallery(data: [GalleryData])
    func showErrorAlert(error: String)
}

class CollectionPresenter {
    
    var delegate: CollectionDelegate?
    
    init() {}
    
    func getImages() {
        let service = GalleryService()
        service.getCatsGallery { (gallery, error) in
            if let err = error {
                self.delegate?.showErrorAlert(error: err)
                return
            }
            
            if let gallery = gallery, !gallery.data.isEmpty {
                self.delegate?.refreshGallery(data: gallery.data)
                return
            }
        }
    }    
}
