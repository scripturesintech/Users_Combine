//
//  ContentView.swift
//  User
//
//  Created by Roopesh Tripathi on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            UserList(viewModel: UserVM())
                .navigationTitle("Users")
        }
    }
}

#Preview {
    ContentView()
}
