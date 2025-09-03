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
            HStack {
                AsyncImage(url: pokemon.pokemonData.sprite)
                    .frame(width: 50, height: 50)
                Text(pokemon.pokemonData.name)
                Button(action: {
                    pokemon.toggleFavourite()
                }) {
                    Image(systemName: pokemon.isFavourite ? "star.fill" : "star")
                }
            }
            .padding()
            
            HStack {
                ForEach(pokemon.pokemonData.types, id:\.name) { type in
                    Text(type.format())
                        .background(type.getBackgroundColour())
                        .foregroundColor(type.getForegroundColour())
                        .cornerRadius(10)
                }
            }

            TextField("", text: $pokemon.nickname)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .autocorrectionDisabled(true)
            
            Grid {
                GridRow {
                    Picker("Move", selection: $pokemon.selectedMoves[0]) {
                        ForEach(pokemon.pokemonData.moves, id:\.name) { move in
                            Text("\(move.format())")
                                .tag(move)
                        }
                    }
                    Picker("Move", selection: $pokemon.selectedMoves[1]) {
                        ForEach(pokemon.pokemonData.moves, id:\.name) { move in
                            Text("\(move.format())")
                                .tag(move)
                        }
                    }
                }
                
                GridRow {
                    Picker("Move", selection: $pokemon.selectedMoves[2]) {
                        ForEach(pokemon.pokemonData.moves, id:\.name) { move in
                            Text("\(move.format())")
                                .tag(move)
                        }
                    }
                    Picker("Move", selection: $pokemon.selectedMoves[3]) {
                        ForEach(pokemon.pokemonData.moves, id:\.name) { move in
                            Text("\(move.format())")
                                .tag(move)
                        }
                    }
                }
            }
        }
    }
}
