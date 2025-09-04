//
//  PokemonType.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 3/9/2025.
//

import SwiftUI

// Struct to hold information regarding Pokemon types.
struct PokemonType: Codable, Formatable {
    let name: String
    
    // Type name can be formatted, so conform to Formatable protocol. Since all Pokemon types are simply one word, the only formatting that needs to be done is capitalising the type name.
    static func format(name: String) -> String {
        return name.capitalized
    }
    
    func format() -> String {
        return PokemonType.format(name: self.name)
    }
    
    // Official Pokemon Type background colours to be used when displaying Pokemon types on the
    // PokemonDetailView.
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
    
    // Lighter tone official Pokemon type colour to be used for List background and PokemonDetailView background.
    // Background colour is based on the Pokemon's primary type.
    func getLighterBackgroundColour() -> Color {
        switch self.name {
        case "normal":
            return Color(hex: 0xE8E8D1)
        case "fire":
            return Color(hex: 0xFFD1B5)
        case "water":
            return Color(hex: 0xB3D1FF)
        case "electric":
            return Color(hex: 0xFFF3B0)
        case "ground":
            return Color(hex: 0xF2E1B2)
        case "grass":
            return Color(hex: 0xC7E6C2)
        case "ice":
            return Color(hex: 0xD0F1F1)
        case "fighting":
            return Color(hex: 0xF2B8B5)
        case "flying":
            return Color(hex: 0xD6CCFA)
        case "poison":
            return Color(hex: 0xE4C1E6)
        case "psychic":
            return Color(hex: 0xFFC4D6)
        case "bug":
            return Color(hex: 0xD9E5A6)
        case "rock":
            return Color(hex: 0xF0E2A2)
        case "ghost":
            return Color(hex: 0xD9CBEF)
        case "dragon":
            return Color(hex: 0xD5C6FA)
        case "dark":
            return Color(hex: 0xC6B9AF)
        case "steel":
            return Color(hex: 0xE3E3F3)
        case "fairy":
            return Color(hex: 0xF7D4E5)
        default:
            return Color.gray
        }
    }

    // Depending on the Pokemon type, what colour text should be displayed above it, as some types have
    // too dark a colour to keep the text black. Make these white instead.
    func getForegroundColour() -> Color {
        switch self.name {
        case "normal", "fighting", "poison", "rock", "bug", "ghost", "psychic", "dragon", "dark":
            return Color.white
        default:
            return Color.black
        }
    }
}
