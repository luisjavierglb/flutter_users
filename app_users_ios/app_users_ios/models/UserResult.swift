//
//  UserResult.swift
//  app_users_ios
//
//  Created by Leonardo Armero Barbosa on 5/8/23.
//

import Foundation

struct UserResult: Codable {
  let results: [User]
}

struct User: Codable {
  let name: UserName
  let email: String
  let picture: UserPicture
}

struct UserName: Codable {
  let title: String
  let first: String
  let last: String
  
  var fullName: String {
    "\(title) \(first) \(last)"
  }
}

struct UserPicture: Codable {
  let large: URL
}
