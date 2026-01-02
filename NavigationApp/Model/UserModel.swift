//
//  UserModel.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/2/26.
//

import Foundation

struct User {
    let userName: String
    let name: String
    let email: String
    let phone: String
    let address: String
    let sex: String
    let age: Int
    var favoriteBooks: [String] // Danh sách ID hoặc tên sách, có thể thay đổi (var)
}
