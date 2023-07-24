//
//  UserViewModel.swift
//  app_users_ios
//
//  Created by Leonardo Armero Barbosa on 5/8/23.
//

import SwiftUI

class UserViewModel: ObservableObject {
  @Published private(set) var users: [UserUI] = []
  
  func fetchUsers() {
    guard let url = URL(string: "https://randomuser.me/api/?results=15") else {
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, _ in
      if let data = data {
        do {
          let result = try JSONDecoder().decode(UserResult.self, from: data)
          DispatchQueue.main.async {
            self.users = result.results.map {
              UserUI(name: $0.name.fullName, email: $0.email, imageUrl: $0.picture.large)
            }
          }
        } catch {
          print(error)
        }
      }
    }.resume()
  }
}
