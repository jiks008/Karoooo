//
//  UserCellViewModel.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import Foundation

struct UserCellViewModel {
    
    var id: Int
    var name: String
    var email: String
    var phone: String
    var address: String
    
    init(with user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        
        var phone = user.phone
        
        if let numberOnly = user.phone.split(separator: " ").first {
            phone = "\(numberOnly)"
        }
        
        self.phone = phone
        self.address = "\(user.address.suite), \(user.address.street), \(user.address.city)-\(user.address.zipcode)"
    }
}
