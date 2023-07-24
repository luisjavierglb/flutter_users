//
//  ContentView.swift
//  app_users_ios
//
//  Created by Leonardo Armero Barbosa on 5/8/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = UserViewModel()
  
  var body: some View {
    VStack {
      HStack {
        Text("Users Page iOS")
          .font(.title)
          .fontWeight(.bold)
          .padding(.vertical, 16)
        
        Button(
          action: {
            viewModel.fetchUsers()
          }
        ) {
          Image(systemName: "arrow.clockwise")
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .shadow(radius: 4)
            .cornerRadius(8)
        }
        .frame(width: 100, height: 64)
        .padding()
      }
      
      ScrollView {
        LazyVStack {
          ForEach(viewModel.users) { user in
            UserListItem(userUi: user)
          }
        }.padding()
      }
    }
    .navigationTitle("Users Page iOS")
    .onAppear {
      viewModel.fetchUsers()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
