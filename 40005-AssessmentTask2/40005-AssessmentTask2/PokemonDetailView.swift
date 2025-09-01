//
//  PokemonDetailView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 1/9/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    @State var pokemon: Pokemon
    
    var body: some View {
        Text(pokemon.pokemonData.name)
    }
}
