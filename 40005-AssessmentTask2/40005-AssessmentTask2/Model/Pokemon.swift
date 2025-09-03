//
//  Pokemon.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct Pokemon: Identifiable, Formatable {
    let id: UUID
    let pokemonData: PokemonData
    var nickname: String
    var isFavourite: Bool
    var selectedMoves: [PokemonMove?]
    
    init(pokemonData: PokemonData) {
        self.id = UUID()
        self.pokemonData = pokemonData
        self.nickname = pokemonData.name
        self.isFavourite = false
        self.selectedMoves = Array(repeating: pokemonData.moves.first, count: 4)
    }
    
    mutating func toggleFavourite() {
        self.isFavourite.toggle()
    }
    
    static func format(name: String) -> String {
        let customFormat = [
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

        if let new = customFormat[name] {
            return new
        } else {
            return name.replacingOccurrences(of: "-", with:" ").capitalized
        }
    }
    
    func format() -> String {
        return Pokemon.format(name: self.pokemonData.name)
    }
}
