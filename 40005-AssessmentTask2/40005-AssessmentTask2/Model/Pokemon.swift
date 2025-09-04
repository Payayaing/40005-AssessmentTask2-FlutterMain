//
//  Pokemon.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

// Struct that holds all relevant information pertaining to the specific Pokemon.
struct Pokemon: Identifiable, Formatable {
    // As this application also includes Pokemon alternate forms, the species name is not an etiquette identifier as this can be repeating (for example, multiple Ogerpon forms have the same species name). We give each Pokemon a unique identifier instead.
    let id = UUID()
    
    // All decoded API data is stored in the PokemonData type.
    let pokemonData: PokemonData
    
    // For users to more accurately identify their builds, especially when there are multiple builds for the same Pokemon species, the users are able to change the Pokemon nickname, or toggle the Pokemon as a favourite.
    var nickname: String
    var isFavourite: Bool
    
    // Array to hold the PokemonMoves that the user selects for their build.
    var selectedMoves: [PokemonMove?]
    
    // When the Pokemon is initialised, the API PokemonData is stored internally within the Pokemon for easy access. The nickname is set to the Pokemon species name, and is automatically not favourited. To fill up the selectedMoves array, it is filled with the first alphabetical PokemonMove that the Pokemon can learn.
    init(pokemonData: PokemonData) {
        self.pokemonData = pokemonData
        self.nickname = pokemonData.name
        self.isFavourite = false
        self.selectedMoves = Array(repeating: pokemonData.moves.first, count: 4)
    }
    
    // Function that allows the user to toggle on or off the favourited status.
    mutating func toggleFavourite() {
        self.isFavourite.toggle()
    }
    
    // When visually displaying the PokemonName, it should be formatted correctly. Most Pokemon can be easily converted from the API kebab-case by capitalising it and replacing any kebabs with spaces. There are some edge cases that need to be addressed, which are stored in the customFormat dictionary.
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
