//
//  UserData.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 04/11/26.
//

import Foundation

struct UserData: Codable {
    var caught: Set<Pokemon.ID>
    var order: [HuntMethod]
    var enabled: Set<HuntMethod>
    var hunts: [Pokemon.ID: Hunt]
}

enum UserDataFile {
    static var url: URL {
        URL.applicationSupportDirectory.appending(path: "user-data.json")
    }
    
    static func load() -> UserData? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(UserData.self, from: data)
    }
    
    static func save(_ userData: UserData) throws {
        try FileManager.default.createDirectory(
            at: .applicationSupportDirectory,
            withIntermediateDirectories: true
        )
        
        let data = try JSONEncoder().encode(userData)
        try data.write(to: url, options: .atomic)
    }
}
