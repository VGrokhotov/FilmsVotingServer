import Vapor
import FluentPostgreSQL

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    // Configuring a controller
    let userController = UserController()
    
    router.get("users", use: userController.all)
    router.get("users", String.parameter, use: userController.show)
    router.post("users", use: userController.create)
    router.put("users", User.parameter, use: userController.update)
    router.delete("users", User.parameter, use: userController.delete)
    
    let roomController = RoomController()
    
    router.get("rooms", use: roomController.all)
    router.get("rooms", "name", String.parameter, use: roomController.showUsingName)
    router.get("rooms", Room.parameter, use: roomController.showUsingId)
    router.post("rooms", use: roomController.create)
    router.put("rooms", User.parameter, use: roomController.update)
    router.delete("rooms", User.parameter, use: roomController.delete)
}
