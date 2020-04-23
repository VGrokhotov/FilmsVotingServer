import Vapor
import FluentPostgreSQL

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return """
        It works!
        

        Users:
        
        *    User Model

                var id: Int?
                var name: String
                var login: String
                var password: Int


        *    Requests:

                GET /users   - all users
                GET /users/login/<user_login>  - get user with String login user_login
                GET /users/<user_id> - get user with Int id user_id

                POST /users - create user

                PUT /users/<user_id> - update user with Int id user_id
                You can not update user_login

                DELETE /users/<user_id> - delete user with Int id user_id


        Rooms:

        *    Room model

                var id: Int?
                var name: String
                var password: String
                var creatorID: Int
                var isVotingAvailable: Bool
                var users: [Int]

        *    Requests:

                GET /rooms   - all rooms
                GET /rooms/name/<room_name>  - get room with String name room_name
                GET /rooms/<room_id> - get room with Int id room_id

                POST /rooms - create room

                PUT /rooms/<room_id> - update room with Int id room_id
                You can not update room_password and room_creatorID

                DELETE /rooms/<room_id> - delete room with Int id room_id


        Options:

        *    Option model
                
                var id: Int?
                var content: String
                var vote: Int
                var roomID: Int

         *   Requests:

                GET /options   - all options
                GET /options/room/<room_id>  - get all options with room id room_id
                GET /options/<option_id> - get option with Int id option_id

                POST /options - create option

                PUT /options/<option_id> - update option with Int id option_id
                You can only update option_vote

                DELETE /options/<option_id> - delete option with Int id options_id
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
    
    let optionController = OptionController()
    
    router.get("options", use: optionController.all)
    router.get("options", "room", Int.parameter, use: optionController.showUsingRoomId)
    router.get("options", Option.parameter, use: optionController.showUsingId)
    router.post("options", use: optionController.create)
    router.put("options", Option.parameter, use: optionController.update)
    router.delete("options", Option.parameter, use: optionController.delete)
}
