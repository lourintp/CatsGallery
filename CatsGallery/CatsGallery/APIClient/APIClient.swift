//
//  APIClient.swift
//  CatsGallery
//
//  Created by Thiago Lourin on 12/03/20.
//  Copyright © 2020 Lourin. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    func requestObject<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>)
}

public class APIClient: APIClientProtocol {
            
    func requestObject<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        let endpoint: URLRequest
        
        do {
            endpoint = try getRequest(for: request, url: "")
        } catch let error{
            completion(.failure(error.localizedDescription))
            return
        }
        
        Alamofire.request(endpoint).validate().responseData { (responseData) in
            guard let data = responseData.data else {
                completion(.failure(responseData.error?.localizedDescription ?? "Failure on getting response from server."))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(response))
                return
            } catch let error {
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    internal func getRequest<T: APIRequest>(for request: T, url: String, _ isTrakt: Bool = true) throws -> URLRequest {
        guard let baseURL = URL(string: request.resourcePath, relativeTo: URL(string: url)) else {
            fatalError("Bad resource name: \(request.resourcePath)")
        }
        
        print(baseURL.absoluteString)
        
        var requestData = URLRequest(url: baseURL)
        
        requestData.httpMethod = HTTPMethod.get.rawValue
        requestData.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (isTrakt) {
            getHeader(&requestData)
        }
        
        return requestData
    }
    
    fileprivate func getHeader(_ requestData: inout URLRequest) {
        requestData.addValue("Client-ID", forHTTPHeaderField: "Authorization")
    }
    
}
