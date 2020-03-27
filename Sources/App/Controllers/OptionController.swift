//
//  OptionController.swift
//  App
//
//  Created by Владислав on 27.03.2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class OptionController {
    
    //MARK: GET
    
    func all(_ req: Request) throws -> Future<[Option]> {
        return Option.query(on: req).all()
    }
    
    func showUsingRoomId(_ req: Request) throws -> Future<[Option]>{
        let roomID = try req.parameters.next(Int.self)
        
        return req.withPooledConnection(to: .psql) { connection in
            return connection.select()
                .all().from(Option.self)
                .where(\Option.roomID == roomID)
                .all(decoding: Option.self).map { rows in
                    if rows.count == 0{
                        throw RoutingError.init(identifier: "404", reason: "There is no option with roomID \(roomID)")
                    } else {
                        return rows
                    }
            }
        }
    }
    
    func showUsingId(_ req: Request) throws -> Future<Option>{
        return try req.parameters.next(Option.self)
    }
    
    
    
    //MARK: POST
    
    func create(_ req: Request) throws -> Future<Option> {
        return try req.content.decode(Option.self).flatMap { option in
            return option.save(on: req)
        }
    }
    
    
    //MARK: PUT
    
    func update(_ req: Request) throws -> Future<Option> {
        return try flatMap(to: Option.self, req.parameters.next(Option.self), req.content.decode(Option.self)) { option, updatedOption in
            option.vote = updatedOption.vote
            return option.save(on: req)
        }
    }
    
    
    //MARK: DELETE
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Option.self).flatMap(to: Void.self) { option in
            return option.delete(on: req)
        }.transform(to: .ok)
    }
    
}
