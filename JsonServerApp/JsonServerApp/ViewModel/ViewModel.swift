//
//  ViewModel.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 21/3/21.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    func getUsers() {
        let url = URL(string: "http://localhost:3000/users")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let usersData = data {
                    let decodedData = try JSONDecoder().decode([User].self, from: usersData)
                    DispatchQueue.main.async {
                        self.users = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    func createUser(user:User) {
        guard let encodedUser = try? JSONEncoder().encode(user) else {
            print("Error encoding newUser")
            return
        }
        let url = URL(string: "http://localhost:3000/users")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedUser
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
        }.resume()
    }
    
    func deleteUser(id: Int) {
        let url = URL(string: "http://localhost:3000/users/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
        }.resume()
    }
    
    func updateUser(user: User) {
        guard let encodedUser = try? JSONEncoder().encode(user) else {
            print("Error encoding newUser")
            return
        }
        let url = URL(string: "http://localhost:3000/users/\(user.id)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = encodedUser
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
        }.resume()
    }
}
