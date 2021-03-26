//
//  User.swift
//  JsonServerApp
//
//  Created by Miguel Ferrer Fornali on 21/3/21.
//

import Foundation

struct User: Codable, Identifiable {
    let id:Int
    let name:String
    let lastname:String
    let age:Int
}
