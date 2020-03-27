import Vapor
import FluentPostgreSQL

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return """
        It works!

        GET /users   - all users
        GET /users/login/<user_login>  - get user with String login user_login
        GET /users/<user_id> - get user with Int id user_id

        POST /users - create user

        PUT /users/<user_id> - update user with Int id user_id

        DELETE /users/<user_id> - delete user with Int id user_id


        GET /rooms   - all rooms
        GET /rooms/name/<room_login>  - get room with String login room_login
        GET /rooms/<room_id> - get room with Int id room_id

        POST /rooms - create room
        PUT /rooms/<room_id> - update room with Int id room_id
        DELETE /rooms/<room_id> - delete room with Int id room_id
        """
    }

    // Configuring a controller
    let userController = UserController()
    
    router.get("users", use: userController.all)
    router.get("users", "login", String.parameter, use: userController.showUsingLogin)
    router.get("users", User.parameter, use: userController.showUsingId)
    router.post("users", use: userController.create)
    router.put("users", User.parameter, use: userController.update)
    router.delete("users", User.parameter, use: userController.delete)
    
    let roomController = RoomController()
    
    router.get("rooms", use: roomController.all)
    router.get("rooms", "name", String.parameter, use: roomController.showUsingName)
    router.get("rooms", Room.parameter, use: roomController.showUsingId)
    router.post("rooms", use: roomController.create)
    router.put("rooms", Room.parameter, use: roomController.update)
    router.delete("rooms", Room.parameter, use: roomController.delete)
}
