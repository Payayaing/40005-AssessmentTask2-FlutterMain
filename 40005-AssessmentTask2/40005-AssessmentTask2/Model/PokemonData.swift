//
//  PokemonData.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

// Decodable struct to store each Pokemon's relevant data when extracted from PokeAPI.
struct PokemonData: Decodable {
    let name: String
    let sprite: URL?
    let moves: [PokemonMove]
    let types: [PokemonType]
    
    // The only Pokemon data that this application uses from the JSON are the Pokemon species, its sprite, a list of moves that it can learn, and its types.
    enum CodingKeys: String, CodingKey {
        case species, sprites, moves, types
    }
    
    init(from decoder: Decoder) throws {
        // From the full JSON file, trim the information down until it only contains the relevant information we need. Decode this information further using various wrappers and allocate internal variables to these, such that all information is accessible without needing to call the API.
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let speciesData = try container.decode(SpeciesWrapper.self, forKey: .species)
        self.name = Pokemon.format(name: speciesData.name)
        
        let spriteData = try container.decode(SpriteWrapper.self, forKey: .sprites)
        self.sprite = URL(string: spriteData.sprite)
        
        // Sort the PokemonMove list such that it's in alphabetical order. This allows users to easily find the specific move they are looking for when using the Pickers in PokemonDetailView.
        let moveData = try container.decode(Array<MoveWrapper>.self, forKey: .moves)
        self.moves = moveData.map({$0.move}).sorted()
        
        let typeData = try container.decode(Array<TypeWrapper>.self, forKey: .types)
        self.types = typeData.map({$0.type})
    }
}

// Wrapper for the Pokemon species.
private struct SpeciesWrapper: Codable {
    let name: String
}

// Wrapper for the Pokemon sprite. When decoding the API JSON file, the only URL sprite that is needed for this application is the "front_default" sprite, which shows the Pokemon from the front. All other sprites are not needed.
private struct SpriteWrapper: Codable {
    let sprite: String
    
    enum CodingKeys: String, CodingKey {
        case sprite = "front_default"
    }
}

// Wrapper for PokemonMove type. The definition for PokemonMove is in its .swift file.
private struct MoveWrapper: Codable {
    let move: PokemonMove
}

// Wrapper for PokemonType type. The definition for PokemonType is in its .swift file.
private struct TypeWrapper: Codable {
    let type: PokemonType
}
