//
//  APIService.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation

actor APIService {
    static let shared = APIService()
    
    public func getAllCharacters() async -> Result<[Character], CustomError> {
        guard let url = URL(string: APIServicePath.characters) else {
            return .failure(.init(message: "Invalid URL."))
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard let parsedDict = APIServiceUtility.tryParseJSON(data) else { return .failure(.init(message: "Failed to Parse Characters."))}
            guard let arrayResults = parsedDict["results"] as? [[String : Any]] else { return .failure(.init(message: "No Characters Available."))}
            var characters = [Character]()
            for result in arrayResults {
                guard let resultAsData = APIServiceUtility.tryConvertToData(result) else { break }
                guard let decodedResult = APIServiceUtility.tryDecodeData(resultAsData, to: Character.self) else { break }
                await DatabaseService.shared.storeCharacter(decodedResult)
                characters.append(decodedResult)
            }
            return .success(characters)
        } catch {
            let allCharactersOnLocalResponse = await DatabaseService.shared.getAllCharacters()
            switch allCharactersOnLocalResponse {
            case .success(let allCharactersOnLocal):
                var characters = [Character]()
                for character in allCharactersOnLocal {
                    characters.append(character)
                }
                return .success(characters)
            case .failure(let error):
                return .failure(.init(message: error.localizedDescription))
            }
            
        }
    }    
}
