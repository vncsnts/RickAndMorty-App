//
//  APIService.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation

actor APIService {
    func getAllCharacters() async -> Result<[Character], ApiError> {
        guard let url = URL(string: APIServicePath.characters) else {
            return .failure(.init(message: "Invalid URL."))
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let parsedDict = APIServiceUtility.tryParseJSON(data) else { return .failure(.init(message: "Failed to Parse Characters."))}
            guard let arrayResults = parsedDict["results"] as? [[String : Any]] else { return .failure(.init(message: "No Characters Available."))}
            var characters = [Character]()
            for result in arrayResults {
                guard let resultAsData = APIServiceUtility.tryConvertToData(result) else { break }
                guard let decodedResult = APIServiceUtility.tryDecodeData(resultAsData, to: Character.self) else { break }
                characters.append(decodedResult)
            }
            return .success(characters)
        } catch {
            return .failure(.init(message: error.localizedDescription))
        }
    }    
}
