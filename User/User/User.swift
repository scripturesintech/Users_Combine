//
//  User.swift
//  User
//
//  Created by Roopesh Tripathi on 23/04/24.
//

import Foundation

struct User: Decodable {
    let id: Int
    let avatar: String
    let firstName: String
    let lastName: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case avatar = "avatar"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
    }
}

struct UserResponse: Decodable {
    let data: [User]
}



