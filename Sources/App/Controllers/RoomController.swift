//
//  RoomController.swift
//  App
//
//  Created by Владислав on 27.03.2020.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class RoomController {
    
    //MARK: GET
    
    func all(_ req: Request) throws -> Future<[Room]> {
        return Room.query(on: req).all()
    }
    
    func showUsingName(_ req: Request) throws -> Future<Room>{
        let name = try req.parameters.next(String.self)
        
        return req.withPooledConnection(to: .psql) { connection in
            return connection.select()
                .all().from(Room.self)
                .where(\Room.name == name)
                .all(decoding: Room.self).map { rows in
                    if rows.count == 0{
                        throw RoutingError.init(identifier: "404", reason: "There is no room with login \(name)")
                    } else {
                        return rows[0]
                    }
            }
        }
    }
    
    func showUsingId(_ req: Request) throws -> Future<Room>{
        return try req.parameters.next(Room.self)
    }
    
    
    
    
    //MARK: POST
    
    func create(_ req: Request) throws -> Future<Room> {
        return try req.content.decode(Room.self).flatMap { room in
            return room.save(on: req)
        }
    }
    
    
    //MARK: PUT
    
    func update(_ req: Request) throws -> Future<Room> {
        return try flatMap(to: Room.self, req.parameters.next(Room.self), req.content.decode(Room.self)) { room, updatedRoom in
            room.name = updatedRoom.name
            room.password = updatedRoom.password
            room.creatorID = updatedRoom.creatorID
            room.isVotingAvailable = updatedRoom.isVotingAvailable
            room.users = updatedRoom.users
            return room.save(on: req)
        }
    }
    
    
    //MARK: DELETE
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Room.self).flatMap(to: Void.self) { room in
            return room.delete(on: req)
        }.transform(to: .ok)
    }
    
}
