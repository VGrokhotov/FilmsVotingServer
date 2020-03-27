//
//  Option.swift
//  App
//
//  Created by Владислав on 26.03.2020.
//


import Foundation
import Vapor
import FluentPostgreSQL

final class Option: PostgreSQLModel, Migration, Content, Parameter, SQLTable{
    
    // Swift 5.2 requires this even though PostgreSQLDatabase constrains Database
    // to this exact type.
    typealias Database = PostgreSQLDatabase
    
    static let sqlTableIdentifierString = "Option"
    
    var id: Int?
    var content: String
    var vote: Int
    var roomID: Int
    
    
    init(id: Int? = nil, content: String, roomID: Int, vote: Int = 0) {
        self.id = id
        self.content = content
        self.roomID = roomID
        self.vote = vote
    }
}
