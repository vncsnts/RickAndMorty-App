//
//  APIServiceUtlity.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation

final class APIServiceUtility {
    static func tryParseJSON(_ data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func tryConvertToData(_ dict: [String: Any]) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func tryDecodeData<T: Decodable>(_ data: Data, to type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedObject = try decoder.decode(type, from: data)
            return decodedObject
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
