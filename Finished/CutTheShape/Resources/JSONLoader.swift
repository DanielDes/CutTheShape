//
//  JSONLoader.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 25/11/21.
//

import Foundation

// MARK: class - JSON Loader
final class JSONLoader {
    class func loadfile<T>(withName name: String) throws -> T? where T : Codable {
        guard let path: String = Bundle.main.path(forResource: name, ofType: "json"),
              let jsonData: Data = try String(contentsOfFile: path).data(using: .utf8) else { return nil }
        let resultObject: T = try JSONDecoder().decode(T.self, from: jsonData)
        return resultObject
    }
}
