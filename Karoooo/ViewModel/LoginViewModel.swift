//
//  LoginViewModel.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import Foundation

struct LoginCredential {
    var username: String = ""
    var password: String = ""
}

class LoginViewModel {
    
    private let userRepository: UserStorage
    
    var showError: ((String) -> Void)?
    var routeToUserList: (() -> Void)?
    
    init(userRepository: UserStorage = SQLiteUserStorage.shared) {
        self.userRepository = userRepository
    }
    
    func isValid(credentials: LoginCredential) -> Bool {
        if credentials.username.isEmpty {
            showError?("Please enter username.")
            return false
        } else if credentials.password.isEmpty {
            showError?("Please enter password.")
            return false
        } else if credentials.username.count < 4 {
            showError?("username length must be from 4 to 20 characters.")
            return false
        } else if credentials.password.count < 5 {
            showError?("password length must be from 5 to 20 characters.")
            return false
        }
        return true
    }
    
    func login(with credential: LoginCredential) {
        if userRepository.validateUserInfo(for: credential.username, pwd: credential.password) {
            routeToUserList?()
        } else {
            showError?("username or password is incorrect.")
        }
    }
}
