//
//  UserView.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 22/3/21.
//

import SwiftUI

struct UserView: View {
    
    var user:User
    @State private var showEditUserView = false
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text(user.name)
                .padding()
            Text(user.lastname)
                .padding()
            Text("\(user.age)")
                .padding()
            Button {
                showEditUserView.toggle()
            } label: {
                Text("Edit user")
            }.padding()
            Button {
                viewModel.deleteUser(id: user.id)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Delete user").foregroundColor(.red)
            }.padding()
        }.sheet(isPresented: self.$showEditUserView, content: {
            EditUserView(userInit: user)
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: 0, name: "", lastname: "", age: 0))
    }
}
