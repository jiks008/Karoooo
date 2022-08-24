//
//  UserListViewModel.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import Foundation

class UserListViewModel {
    
    private var userService: UsersServiceProtocol
    private var users = Users()

    var userCellViewModels = [UserCellViewModel]() {
        didSet {
            displayUsers?()
        }
    }
   
    var displayUsers: (() -> Void)?
    
    init(userService: UsersServiceProtocol = UsersService()) {
        self.userService = userService
    }
    
    func getUsers() {
        userService.getUsers { users, error in
            if let users = users {
                self.fetchData(users: users)
            } else {
                print(error ?? "")
            }
        }
    }
    
    func userDetailViewModel(for index: Int) -> UserDetailsViewModel? {
        guard index < users.count else { return nil }
        return UserDetailsViewModel(user: users[index])
    }
    
    private func fetchData(users: Users) {
        self.users = users
        userCellViewModels = users.map { UserCellViewModel(with: $0) }
    }
}
