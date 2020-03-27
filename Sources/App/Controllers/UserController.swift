//
//  UserController.swift
//  App
//
//  Created by Владислав on 04.03.2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class UserController {
    
    //MARK: GET
    
    func all(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func show(_ req: Request) throws -> Future<User>{
        let login = try req.parameters.next(String.self)
        
        return req.withPooledConnection(to: .psql) { connection in
            return connection.select()
                .all().from(User.self)
                .where(\User.login == login)
                .all(decoding: User.self).map { rows in
                    if rows.count == 0{
                        throw RoutingError.init(identifier: "404", reason: "There is no user with login \(login)")
                    } else {
                        return rows[0]
                    }
            }
        }
    }
    
    
    
    //MARK: POST
    
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    
    //MARK: PUT
    
    func update(_ req: Request) throws -> Future<User> {
        return try flatMap(to: User.self, req.parameters.next(User.self), req.content.decode(User.self)) { user, updatedUser in
            user.name = updatedUser.name
            user.password = updatedUser.password
            user.login = updatedUser.login
            return user.save(on: req)
        }
    }
    
    
    //MARK: DELETE
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap(to: Void.self) { user in
            return user.delete(on: req)
        }.transform(to: .ok)
    }
    
}
