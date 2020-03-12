//
//  APIRequest.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 11/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    var resourcePath: String  { get }
    
    associatedtype Response: APIResponse
}
