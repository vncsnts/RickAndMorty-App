//
//  DatabaseServiceModels.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation
import RealmSwift

class Character: Object, Identifiable, Decodable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var species: String = ""
    @Persisted var type: String = ""
    @Persisted var gender: String = ""
    @Persisted var image: String = ""
    @Persisted var url: String = ""
    @Persisted var created: String = ""
    @Persisted var episodes = List<String>()
    @Persisted var origin: Location? = nil
    @Persisted var location: Location? = nil
    @Persisted var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, image, url, created, episode
        case origin, location
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        image = try container.decode(String.self, forKey: .image)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
        episodes = try container.decode(List<String>.self, forKey: .episode)
        origin = try container.decode(Location.self, forKey: .origin)
        location = try container.decode(Location.self, forKey: .location)
    }
}

class Location: Object, Decodable {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }
}
