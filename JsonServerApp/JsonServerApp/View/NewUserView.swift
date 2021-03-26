//
//  NewUserView.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 22/3/21.
//

import SwiftUI

struct NewUserView: View {
    
    @State private var name = ""
    @State private var lastname = ""
    @State private var age = 18
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: self.$name)
                        .disableAutocorrection(true)
                    TextField("Lastname", text: self.$lastname)
                        .disableAutocorrection(true)
                    Stepper("Age: \(age)", value: self.$age, in: 1...100)
                }
            }
            .navigationBarTitle("New user", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                })
            , trailing:
                Button(action: {
                    viewModel.createUser(user: User(id: 0, name: name, lastname: lastname, age: age))
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                }).disabled(name.isEmpty || lastname.isEmpty)
            )
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}
