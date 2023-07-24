//
//  UserListItem.swift
//  app_users_ios
//
//  Created by Leonardo Armero Barbosa on 5/8/23.
//

import SwiftUI

struct UserListItem: View {
  let userUi: UserUI
  @State private var image: UIImage?
  
  var body: some View {
    HStack {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .frame(width: 64, height: 64)
          .aspectRatio(contentMode: .fit)
          .cornerRadius(8)
      } else {
        Image(systemName: "person")
          .resizable()
          .frame(width: 64, height: 64)
          .aspectRatio(contentMode: .fit)
      }
      
      VStack(alignment: .leading) {
        Text(userUi.name).font(.headline)
        Text(userUi.email).font(.subheadline)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(16.0)
    .overlay(
      Rectangle()
        .stroke(.gray, lineWidth: 2.0)
    )
    .onAppear {
      loadImage()
    }
  }
  
  private func loadImage() {
    URLSession.shared.dataTask(with: userUi.imageUrl) { data, _, error in
      if let data = data, let image = UIImage(data: data) {
        DispatchQueue.main.async {
          self.image = image
        }
      }
    }.resume()
  }
}
