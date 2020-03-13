//
//  GalleryService.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 13/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

class GalleryService {
    
    func getCatsGallery(completionHandler: @escaping (Gallery?, String?) -> ()) {
        let apiClient = APIClient()
        apiClient.requestObject(GallerySearchRequest(filter: "cats"), completion: { (response) in
            switch response {
            case .success(let result):
                let decoded = result as! Gallery
                completionHandler(decoded, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        })
    }    
}
