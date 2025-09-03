//
//  PokemonData.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct PokemonData: Decodable {
    let name: String
    let sprite: URL?
    let moves: [PokemonMove]
    let types: [PokemonType]
    
    enum CodingKeys: String, CodingKey {
        case species, sprites, moves, types
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let speciesData = try container.decode(SpeciesWrapper.self, forKey: .species)
        self.name = Pokemon.format(name: speciesData.name)
        
        let spriteData = try container.decode(SpriteWrapper.self, forKey: .sprites)
        self.sprite = URL(string: spriteData.sprite)
        
        let moveData = try container.decode(Array<MoveWrapper>.self, forKey: .moves)
        self.moves = moveData.map({$0.move}).sorted()
        
        let typeData = try container.decode(Array<TypeWrapper>.self, forKey: .types)
        self.types = typeData.map({$0.type})
    }
}

// Unwrapping species data.
private struct SpeciesWrapper: Codable {
    let name: String
}

// Unwrapping sprite data.
private struct SpriteWrapper: Codable {
    let sprite: String
    
    enum CodingKeys: String, CodingKey {
        case sprite = "front_default"
    }
}

// Unwrapping move data.
private struct MoveWrapper: Codable {
    let move: PokemonMove
}

// Unwrapping type data.
private struct TypeWrapper: Codable {
    let type: PokemonType
}
