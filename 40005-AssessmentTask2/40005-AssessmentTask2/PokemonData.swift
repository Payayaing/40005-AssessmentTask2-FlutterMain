//
//  PokemonData.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct PokemonData: Decodable {
    let species: String
    let sprite: URL?
    
    enum CodingKeys: String, CodingKey {
        case species = "species"
        case sprites = "sprites"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let speciesData = try container.decode(Species.self, forKey: .species)
        self.species = speciesData.species
        
        let spriteData = try container.decode(Sprite.self, forKey: .sprites)
        self.sprite = URL(string: spriteData.sprite)
    }
}

private struct Species: Codable {
    let species: String
}

private struct Sprite: Codable {
    let sprite: String
    enum CodingKeys: String, CodingKey {
        case sprite = "front_default"
    }
}
