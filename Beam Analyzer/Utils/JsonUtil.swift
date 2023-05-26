//
//  JsonUtil.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.05.2023.
//

import Foundation

final class JsonUtil {
    static func convertToJsonString<T: Codable>(object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
    
    static func convertToObject<T: Codable>(jsonString: String, objectType: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Invalid JSON string")
            return nil
        }
        
        do {
            let object = try decoder.decode(objectType, from: jsonData)
            return object
        } catch {
            return nil
        }
    }
    
}
