//
//  User.swift
//  app_users_ios
//
//  Created by Leonardo Armero Barbosa on 5/8/23.
//

import SwiftUI

struct UserUI: Identifiable {
  let id = UUID()
  let name: String
  let email: String
  let imageUrl: URL
}
