//
//  UserList.swift
//  User
//
//  Created by Roopesh Tripathi on 23/04/24.
//

import SwiftUI

struct UserList: View {
    @ObservedObject var viewModel: UserVM
   
    var body: some View {
        List(viewModel.users, id: \.id) { user in
            HStack {
                HStack {
                    let avatarURL = URL(string: user.avatar)
                    AsyncImage(url: avatarURL) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            @unknown default:
                                EmptyView()
                        }
                    }
                }.frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
