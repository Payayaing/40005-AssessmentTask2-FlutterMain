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
        ZStack {
            pokemon.pokemonData.types[0].getLighterBackgroundColour().ignoresSafeArea()
            VStack {
                HStack {
                    // Resizing the Pokemon sprite to take up more of the screen.
                    AsyncImage(url: pokemon.pokemonData.sprite) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 150, height: 150)
                    
                    VStack {
                        HStack {
                            Text(pokemon.pokemonData.name)
                                .font(.title)
                                .bold()
                            Button(action: {
                                pokemon.toggleFavourite()
                            }) {
                                Image(systemName: pokemon.isFavourite ? "star.fill" : "star")
                            }
                        }
                        .padding(.horizontal, 5)
                        
                        // For each type that the Pokemon could have (1 or 2), display them as Text and use the corresponding background and foreground colours.
                        HStack {
                            ForEach(pokemon.pokemonData.types, id:\.name) { type in
                                Text(type.format())
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(type.getBackgroundColour())
                                    .foregroundColor(type.getForegroundColour())
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                
                // Allows the user to efficiently edit their Pokemon's nickname.
                HStack {
                    Text("Nickname:")
                        .font(.headline)
                    TextField("", text: $pokemon.nickname)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 20)
                        .autocorrectionDisabled(true)
                }
                .padding()
                .padding(.bottom, 50)
                
                // Each PokemonMove is laid out in a Grid, with each move having its own Picker.
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
        }
        .accentColor(.black)
    }
}
