//
//  UsersDetailsViewModel.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import Foundation

class UserDetailsViewModel {
    
    let name: String
    let latitude: Double
    let longitude: Double

    var noOfItemsToDisplay: Int { userDetailsCellViewModels.count }
    
    private let user: User
    private let userDetailsCellViewModels: [UserDetailsCellViewModel]
    
    init(user: User) {
        self.user = user
        self.userDetailsCellViewModels = (0...8).map { Self.createCellModel(for: user, at: $0) }
        
        name = user.name
        latitude = Double(user.address.geo.lat) ?? 0
        longitude = Double(user.address.geo.lng) ?? 0
    }
    
    private static func createCellModel(for user: User, at index: Int) -> UserDetailsCellViewModel {
        var title = ""
        var details = ""
        
        switch index {
        case 0:
            title = "Name"
            details = user.name
        case 1:
            title = "Username"
            details = user.username
        case 2:
            title = "Email"
            details = user.email
        case 3:
            title = "Phone"
            details = user.phone
        case 4:
            title = "Address"
            details = "\(user.address.suite), \(user.address.street), \(user.address.city)-\(user.address.zipcode)"
        case 5:
            title = "Website"
            details = user.website
        case 6:
            title = "Company name"
            details = user.company.name
        case 7:
            title = "Company catchphrase"
            details = user.company.catchPhrase
        case 8:
            title = "Company bs"
            details = user.company.bs
        default:
            title = ""
            details = ""
        }
        
        return UserDetailsCellViewModel(title: title, details: details)
    }
    
    func getCellViewModel(at index: Int) -> UserDetailsCellViewModel? {
        guard index < userDetailsCellViewModels.count else { return nil }
        
        return userDetailsCellViewModels[index]
    }
}

