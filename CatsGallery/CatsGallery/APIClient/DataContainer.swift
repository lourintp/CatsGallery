//
//  DataContainer.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 11/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable> : Decodable {
    public let results: Results
}
