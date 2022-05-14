//
//  DiskCaretaker.swift
//  RabbleWabble
//
//  Created by Fabio Tiberio on 17/04/22.
//

import Foundation

public final class DiskCaretaker {
    public static let encoder = JSONEncoder()
    public static let decoder = JSONDecoder()
    
    public static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
    public static func save<T: Codable>(_ object: T, to fileName: String) throws {
        let url = createDocumentURL(withFileName: fileName)
        let data = try encoder.encode(object)
        try data.write(to: url, options: .atomic)
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumentURL(withFileName: fileName)
        return try retrieve(type, from: url)
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try decoder.decode(type, from: data)
    }
}
