//
//  EditUserView.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 23/3/21.
//

import SwiftUI

struct EditUserView: View {
    
    var user:User
    @State private var name:String
    @State private var lastname:String
    @State private var age:Int
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(userInit:User) {
        self.user = userInit
        self._name = State(wrappedValue: userInit.name)
        self._lastname = State(wrappedValue: userInit.lastname)
        self._age = State(wrappedValue: userInit.age)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: self.$name)
                        .disableAutocorrection(true)
                    TextField("Name", text: self.$lastname)
                        .disableAutocorrection(true)
                    Stepper("Age: \(age)", value: self.$age, in: 1...100)
                }
            }
            .navigationBarTitle("Edit user", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
            , trailing:
                Button(action: {
                    let newUser = User(id: user.id, name: name, lastname: lastname, age: age)
                    viewModel.updateUser(user: newUser)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                }).disabled(name.isEmpty || lastname.isEmpty)
            )
        }
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(userInit: User(id: 0, name: "", lastname: "", age: 0))
    }
}
