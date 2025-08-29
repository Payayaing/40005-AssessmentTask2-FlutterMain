//
//  PokemonView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct PokemonView: View {
    @Binding var pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: pokemon.pokemonData.sprite)
        }
    }
}
