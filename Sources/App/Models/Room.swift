//
//  Room.swift
//  App
//
//  Created by Владислав on 26.03.2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Room: PostgreSQLModel, Migration, Content, Parameter, SQLTable{
    
    // Swift 5.2 requires this even though PostgreSQLDatabase constrains Database
    // to this exact type.
    typealias Database = PostgreSQLDatabase
    
    static let sqlTableIdentifierString = "Room"
    
    var id: Int?
    var name: String
    var password: Int
    var creatorID: Int
    var isVotingAvailable: Bool
    var users: [Int]
    
    
    init(id: Int? = nil, name: String, password: Int, creatorID: Int, isVotingAvailable: Bool = false, users: [Int] = []) {
        self.id = id
        self.name = name
        self.password = password
        self.creatorID = creatorID
        self.isVotingAvailable = isVotingAvailable
        self.users = users
    }
}
