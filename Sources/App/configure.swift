
import Foundation
import Vapor
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    
    // Configure a PostgreSQL database
    
    let postgreSQLConfig : PostgreSQLDatabaseConfig
      
    if let url = Environment.get("DATABASE_URL") {
      postgreSQLConfig = PostgreSQLDatabaseConfig(url: url)!
    } else {
      postgreSQLConfig = PostgreSQLDatabaseConfig(hostname: "localhost", username: "vladislav", database: "filmsvoting", password: nil, transport: .cleartext)
    }
    let postgresql = PostgreSQLDatabase(config: postgreSQLConfig)

    // Register the configured PostgreSQL database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: postgresql, as: .psql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: Room.self, database: .psql)
    migrations.add(model: Option.self, database: .psql)

    services.register(migrations)
}
