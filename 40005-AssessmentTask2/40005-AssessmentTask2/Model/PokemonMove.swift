//
//  PokemonMove.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 3/9/2025.
//

import SwiftUI

// Struct to hold information regarding Pokemon moves, mainly just the name of the move itself and formatting functions.
struct PokemonMove: Codable, Hashable, Comparable, Formatable {
    let name: String
    
    // When visually displaying the Pokemon moves, they should be formatted correctly. Some moves require custom formatting, and this is implementing using the kebab-case move names obtained from the API as the dictionary key, and the formatted version as its value.
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
    
    // To allow Pokemon moves to be selected using a Picker, they must conform to Comparable, which is what these methods are implementing.
    static func < (lhs: PokemonMove, rhs: PokemonMove) -> Bool {
        return lhs.name < rhs.name
    }

    static func == (lhs: PokemonMove, rhs: PokemonMove) -> Bool {
        return lhs.name == rhs.name
    }
}
