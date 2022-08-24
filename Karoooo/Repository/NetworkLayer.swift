//
//  NetworkLayer.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import Foundation

// MARK: - WebServiceControllerError
public enum APIError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

class APIRequests {
    
    func GET(for url: String, params: [String: String] = [:], completionHandler: @escaping (Data?, APIError?) -> Void) {
        
        guard var components = URLComponents(string: url) else {
            completionHandler(nil, APIError.invalidURL(url))
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let endpointURL = components.url else {
            completionHandler(nil, APIError.invalidURL(url))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: endpointURL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                completionHandler(nil, APIError.forwarded(error!))
                return
            }
            guard let responseData = data else {
                completionHandler(nil, APIError.invalidPayload(endpointURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                completionHandler(nil, APIError.forwarded(error!))
                return
            }
            
            completionHandler(responseData, nil)
        })
        
        dataTask.resume()
    }
}
