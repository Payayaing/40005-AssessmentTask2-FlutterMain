//
//  Pokemon.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

class Pokemon: Identifiable {
    let id = UUID()
    let pokemonData: PokemonData
    var isFavourite: Bool = false
    
    @Published var nickname: String
    
    @Published var move1: PokemonMove?
    @Published var move2: PokemonMove?
    @Published var move3: PokemonMove?
    @Published var move4: PokemonMove?
    
    init(pokemonData: PokemonData) {
        self.pokemonData = pokemonData
        self.nickname = pokemonData.name
        
        self.move1 = pokemonData.moves.first
        self.move2 = pokemonData.moves.first
        self.move3 = pokemonData.moves.first
        self.move4 = pokemonData.moves.first
    }
    
    static func formatName(pokemonName: String) -> String {
        let customNames = [
            "nidoran-f": "Nidoran (F)",
            "nidoran-m": "Nidoran (M)",
            "farfetch-d": "Farfetch'd",
            "sirfetch-d": "Sirfetch'd",
            "ho-oh": "Ho-Oh",
            "mime-jr": "Mime Jr.",
            "mr-mime": "Mr. Mime",
            "mr-rime": "Mr. Rime",
            "porygon-z": "PorygonZ",
            "jangmo-o": "Jangmo-o",
            "hakamo-o": "Hakamo-o",
            "kommo-o": "Kommo-o",
            "type-null": "Type: Null",
            "wo-chien": "Wo-Chien",
            "chi-yu": "Chi-Yu",
            "chien-pao": "Chien-Pao",
            "ting-lu": "Ting-Lu"
        ]

        if let newName = customNames[pokemonName] {
            return newName
        } else {
            return pokemonName.replacingOccurrences(of: "-", with:" ").capitalized
        }
    }
    
    func formatName() -> String {
        return Pokemon.formatName(pokemonName: self.pokemonData.name)
    }
    
    func makeFavourite() {
        self.isFavourite = true
    }
}
