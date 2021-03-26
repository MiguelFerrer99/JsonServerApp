//
//  ContentView.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var showNewUserView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink(
                        destination: UserView(user: user),
                        label: {
                            Text("\(user.name) \(user.lastname)")
                        }
                    )
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.getUsers()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                    Button(action: {
                        showNewUserView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            )
        }.sheet(isPresented: self.$showNewUserView, content: {
            NewUserView()
        })
        .onAppear {
            viewModel.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
