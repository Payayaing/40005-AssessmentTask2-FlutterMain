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
    
    @Published var move1: PokemonMove?
    @Published var move2: PokemonMove?
    @Published var move3: PokemonMove?
    @Published var move4: PokemonMove?
    
    init(pokemonData: PokemonData) {
        self.pokemonData = pokemonData
        
        self.move1 = pokemonData.moves.first
        self.move2 = pokemonData.moves.first
        self.move3 = pokemonData.moves.first
        self.move4 = pokemonData.moves.first
    }
    
    func makeFavourite() {
        self.isFavourite = true
    }
}
