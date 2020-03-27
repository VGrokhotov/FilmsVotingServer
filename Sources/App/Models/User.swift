//
//  User.swift
//  App
//
//  Created by Владислав on 04.03.2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class User: PostgreSQLModel, Migration, Content, Parameter, SQLTable{
    
    // Swift 5.2 requires this even though PostgreSQLDatabase constrains Database
    // to this exact type.
    typealias Database = PostgreSQLDatabase
    
    static let sqlTableIdentifierString = "User"
   
    var id: Int?
    var name: String
    var login: String
    var password: Int
    
    
    init(name: String, login: String, id: Int? = nil, password: Int) {
        self.name = name
        self.id = id
        self.password = password
        self.login = login
    }
    
}


