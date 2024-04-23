//
//  User.swift
//  TodoApp
//
//  Created by alihizardere on 13.04.2024.
//

import Foundation

struct User {
    let email: String
    let name: String
    let profieImageUrl: String
    let uid: String
    let username: String
    
    init(data: [String: Any]) {
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.profieImageUrl = data["profileImageUrl"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
    }
}
