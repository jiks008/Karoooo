//
//  UsersService.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import Foundation

protocol UsersServiceProtocol {
    func getUsers(completion: @escaping (_ results: Users?, _ error: APIError?) -> ())
}

class UsersService: UsersServiceProtocol {
    
    private let API = APIRequests()
    
    func getUsers(completion: @escaping (Users?, APIError?) -> ()) {
        API.GET(for: "https://jsonplaceholder.typicode.com/users") { data, error in
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(Users.self, from: data)
                    completion( model, nil)
                } catch {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // try to read out a string array
                        if let names = json["names"] as? [String] {
                            print(names)
                        }
                    }
                    completion(nil, .invalidURL("https://jsonplaceholder.typicode.com/users"))
                }
            } else {
                completion(nil, error)
            }
        }
    }
}

