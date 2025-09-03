//
//  HomeView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

struct HomeView: View {
    @StateObject var userPokemon = HomeViewModel()
    @State var searchPokemon: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("Your Saved Pokemon")
                    .font(.largeTitle)
                    .bold()
                
                if userPokemon.userPokemon.isEmpty {
                    Spacer()
                    Text("Add some Pokemon!")
                        .font(.headline)
                        .bold()
                    Spacer()
                } else {
                    List {
                        ForEach($userPokemon.userPokemon, id: \.pokemonData.name) { $pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: $pokemon)) {
                                HStack {
                                    AsyncImage(url: pokemon.pokemonData.sprite)
                                    
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
