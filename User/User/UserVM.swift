//
//  UserVM.swift
//  User
//
//  Created by Roopesh Tripathi on 23/04/24.
//

import Foundation
import Combine

class UserVM: ObservableObject {
    
    @Published var users: [User] = []
    @Published var error: Error?
    private var cancellable = Set<AnyCancellable>()
    private let networkManager: NetworkProtocol
    private let url: URL
    
    init(networkManager: NetworkProtocol = NetworkManager(),
         url: URL = URL(string: "https://reqres.in/api/users?page=2")!) {
        self.networkManager = networkManager
        self.url = url
    }
    
    func fetchUsers() {
        networkManager.fetchData(from: url)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                switch item {
                case .failure(let _error):
                    self?.error = _error
                case .finished: debugPrint("operation complete!")
                }
            } receiveValue: { [weak self] _users in
                self?.users = _users
            }.store(in: &cancellable)
    }
}
