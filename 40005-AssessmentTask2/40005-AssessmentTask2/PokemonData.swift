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
    let abilities: [PokemonAbility]
    
    enum CodingKeys: String, CodingKey {
        case species, sprites, moves, types, stats, abilities
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let speciesData = try container.decode(SpeciesWrapper.self, forKey: .species)
        self.name = Pokemon.formatName(pokemonName: speciesData.name)
        
        let spriteData = try container.decode(SpriteWrapper.self, forKey: .sprites)
        self.sprite = URL(string: spriteData.sprite)
        
        let moveData = try container.decode(Array<MoveWrapper>.self, forKey: .moves)
        self.moves = moveData.map({$0.move})
        
        let typeData = try container.decode(Array<TypeWrapper>.self, forKey: .types)
        self.types = typeData.map({$0.type})
        
        let abilityData = try container.decode(Array<AbilityWrapper>.self, forKey: .abilities)
        self.abilities = abilityData.map(\.ability)
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

struct PokemonMove: Codable, Hashable {
    let name: String
    
    func formatMove() -> String {
        let customFormat = [
            "lands-wrath": "Land's Wrath",
            "baby-doll-eyes": "Baby-Doll Eyes",
            "forests-curse": "Forest's Curse",
            "freeze-dry": "Freeze-Dry",
            "lock-on": "Lock-On",
            "mud-slap": "Mud-Slap",
            "multi-attack": "Multi-Attack",
            "natures-madness": "Nature's Madness",
            "power-up-punch": "Power-Up Punch",
            "self-destruct": "Self-Destruct",
            "trick-or-treat": "Trick-Or-Treat",
            "u-turn": "U-Turn",
            "v-create": "V-Create",
            "wake-up-slap": "Wake-Up Slap",
            "will-o-wisp": "Will-O-Wisp",
            "x-scissor": "X-Scissor"
        ]

        if let new = customFormat[self.name] {
            return new
        } else {
            return self.name.replacingOccurrences(of: "-", with: " ").capitalized
        }
    }
}

// Unwrapping type data.
private struct TypeWrapper: Codable {
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

// Unwrapping ability data.
private struct AbilityWrapper: Codable {
    let ability: PokemonAbility
}

struct PokemonAbility: Codable {
    let name: String
}
