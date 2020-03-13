//
//  GallerySearchRequest.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 12/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

struct GallerySearchRequest: APIRequest {
    
    let filter: String
    
    init(filter: String) {
        self.filter = filter
    }
    
    var resourcePath: String {
        return "/3/gallery/search/?q=\(filter)"
    }
    typealias Response = Gallery
    
    
}
