//
//  PokemonDetailView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 1/9/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    @Binding var pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: pokemon.pokemonData.sprite)
            Text(pokemon.pokemonData.name)
            Picker("Move", selection: $pokemon.move1) {
                ForEach(pokemon.pokemonData.moves, id:\.name) { move in
                    Text(move.name)
                        .tag(move)
                }
            }
        }
    }
}
