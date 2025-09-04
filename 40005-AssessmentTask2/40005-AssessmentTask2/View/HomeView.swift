//
//  HomeView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

struct HomeView: View {
    // The list of the users Pokemon should be persistent throughout the application.
    @StateObject var userPokemon = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("Your Saved Pokemon")
                    .font(.largeTitle)
                    .bold()
                
                // If the user has no Pokemon saved, they should be prompted to add a Pokemon to their list.
                if userPokemon.userPokemon.isEmpty {
                    Spacer()
                    Text("Add some Pokemon!")
                        .font(.headline)
                        .bold()
                    Spacer()
                } else {
                    // If the user has Pokemon saved, go through each of their Pokemon and display as a list item. Tapping on a Pokemon takes them to the PokemonDetailView which allows them to edit that specific Pokemon. The 'preview' Pokemon should have sufficient detail to allow the user to infer what they have stored in that Object.
                    List {
                        ForEach($userPokemon.userPokemon) { $pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: $pokemon)) {
                                HStack {
                                    AsyncImage(url: pokemon.pokemonData.sprite)
                                    
                                    // If the Pokemon does not have a nickname, then just display its default name instead. If it does, show the nickname, but also show the default name in brackets.
                                    if pokemon.nickname == pokemon.pokemonData.name {
                                        Text(pokemon.nickname)
                                            .font(.headline)
                                    } else {
                                        Text("\(pokemon.nickname) (\(pokemon.pokemonData.name))")
                                            .font(.headline)
                                    }
                                    Spacer()
                                    Image(systemName: pokemon.isFavourite ? "star.fill" : "star")
                                }
                            }
                            .listRowBackground(pokemon.pokemonData.types[0].getLighterBackgroundColour())
                        }
                        .onDelete(perform: userPokemon.deletePokemon)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                // Large button that takes the user to the SelectorView, which allows them to add Pokemon to their build list. This passes the userPokemon (View Model) object such that the SelectorView can then correctly add the selected Pokemon to the full list.
                NavigationLink(destination: SelectorView(userPokemon: userPokemon)) {
                    HStack {
                        Text("Add Pokemon")
                            .font(.headline)
                        Image("Pokeball")
                            .resizable()
                            .scaledToFill()
                            .frame(width:50, height: 35)
                    }
                    .padding()
                    .frame(maxWidth: 400)
                    .background(Color(hex: 0xA6CAF5))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
