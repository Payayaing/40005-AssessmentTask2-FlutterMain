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
        case species, sprites, moves, types, stats
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

struct PokemonMove: Codable, Hashable, Comparable, Formatable {
    let name: String
    
    static func format(name: String) -> String {
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

        if let new = customFormat[name] {
            return new
        } else {
            return name.replacingOccurrences(of: "-", with: " ").capitalized
        }
    }
    
    func format() -> String {
        return PokemonMove.format(name: self.name)
    }
    
    // Allowing pokemon moves to be sorted
    static func < (lhs: PokemonMove, rhs: PokemonMove) -> Bool {
        return lhs.name < rhs.name
    }

    static func == (lhs: PokemonMove, rhs: PokemonMove) -> Bool {
        return lhs.name == rhs.name
    }
}

// Unwrapping type data.
private struct TypeWrapper: Codable {
    let type: PokemonType
}

struct PokemonType: Codable, Formatable {
    let name: String
    
    static func format(name: String) -> String {
        return name.capitalized
    }
    
    func format() -> String {
        return PokemonType.format(name: self.name)
    }
    
    func getBackgroundColour() -> Color {
        switch (self.name) {
        case "normal":
            return Color(hex: 0xA8A77A)
        case "fire":
            return Color(hex: 0xEE8130)
        case "water":
            return Color(hex: 0x6390F0)
        case "electric":
            return Color(hex: 0xF7D02C)
        case "ground":
            return Color(hex: 0xE2BF65)
        case "grass":
            return Color(hex: 0x7AC74C)
        case "ice":
            return Color(hex: 0x96D9D6)
        case "fighting":
            return Color(hex: 0xC22E28)
        case "flying":
            return Color(hex: 0xA98FF3)
        case "poison":
            return Color(hex: 0xA33EA1)
        case "psychic":
            return Color(hex: 0xF95587)
        case "bug":
            return Color(hex: 0xA6B91A)
        case "rock":
            return Color(hex: 0xB6A136)
        case "ghost":
            return Color(hex: 0x735797)
        case "dragon":
            return Color(hex: 0x6F35FC)
        case "dark":
            return Color(hex: 0x705746)
        case "steel":
            return Color(hex: 0xB7B7CE)
        case "fairy":
            return Color(hex: 0xD685AD)
        default:
            return Color.gray
        }
    }
    
    func getForegroundColour() -> Color {
        switch self.name {
        case "normal", "fighting", "poison", "rock", "bug", "ghost", "psychic", "dragon", "dark":
            return Color.white
        default:
            return Color.black
        }
    }
}
