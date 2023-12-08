import Vapor

func routes(_ app: Application) throws {
    app.get("hello", ":name") { req async -> String in
        let name = try! req.parameters.require("name", as: String.self)
        return "hello \(name)"
    }
    
    app.post("info") { req async -> String in
        do {
            let info = try req.content.decode(InfoData.self)
            return "Hello \(info.name)"
        } catch {
            return error.localizedDescription
        }
    }
    
    app.get("date") { _ -> String in
        let date = Date.now.formatted()
        return date
    }
    
    app.get("count", ":count") { req async -> CountData in
        do {
            let count = try req.parameters.require("count", as: Int.self)
            return CountData(count: count)
        } catch {
            return CountData(count: 0)
        }
    }
    
    app.post("user-info") { req async -> String in
        do {
            let data = try req.content.decode(UserInfoData.self)
            return "My name is \(data.name) and I'm \(data.age) years old"
        } catch {
            return error.localizedDescription
        }
    }
}

struct InfoData: Content {
    let name: String
}

struct CountData: Content {
    let count: Int
}

struct UserInfoData: Content {
    let name: String
    let age: Int
}
