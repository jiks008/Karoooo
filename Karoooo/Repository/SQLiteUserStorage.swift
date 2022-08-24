//
//  StorageLayer.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 23/08/22.
//

import Foundation
import SQLite

protocol UserStorage {
    func validateUserInfo(for uname: String, pwd: String) -> Bool
}

class SQLiteUserStorage: UserStorage {
   
    static let shared = SQLiteUserStorage()
   
    let username = Expression<String>("username") // non-null
    let password = Expression<String?>("password")  // nullable
    
    let dbPath = SQLiteUserStorage.getFileDocumentPath(fileName: "db.sqlite3")
    
    private init() {
        do {
            
            print("dbPath = \(dbPath)")
            let db = try Connection(dbPath)
        
            /// enable statement logging
            db.trace { print($0) }
            /// define a "users" table with some fields
            let users = Table("users")
            let id = Expression<Int64>("id")
            
            /// prepare the query
            let statement = users.create { t in
                t.column(id, primaryKey: true)
                t.column(username, unique: true)
                t.column(password)
            }
            /// …and run it
            try db.run(statement)
            
            let insert = users.insert(username <- "admin", password <- "admin")
            try db.run(insert)

            let insert2 = users.insert(username <- "TheUser", password <- "TheOnePassword")
            try db.run(insert2)

        }  catch {
            print (error)
        }
        
    }
    
    static func getFileDocumentPath(fileName: String) -> String {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let newDirectory = directory.appendingPathComponent(fileName)
            return newDirectory.path
        } else {
            return "\(#function) Error"
        }
    }
    
    func validateUserInfo(for uname: String, pwd: String) -> Bool {
        do {
            let db = try Connection(dbPath)
            if let c = try db.scalar("SELECT count(*) FROM users WHERE username = '\(uname)' AND password = '\(pwd)'") as? Int64, c > 0 {
                print(c)
                return true
            } else {
                return false
            }
        } catch {
            print(error)
        }
        return false
    }
}
