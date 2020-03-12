//
//  Result.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 11/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(String)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
