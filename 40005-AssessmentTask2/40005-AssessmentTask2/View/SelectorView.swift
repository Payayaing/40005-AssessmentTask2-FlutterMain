//
//  SelectorView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct SelectorView: View {
    @State var searchQuery: String = ""
    @ObservedObject private var pokemonList = SelectorViewModel()
    @ObservedObject var userPokemon: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var isLoading = true
    
    var body: some View {
        VStack {
            Text("Select Pokemon")
                .font(.largeTitle)
                .bold()
            
            // Search TextField is added to allow the user to specify the Pokemon they are looking for without needing to scroll through 1000+ Pokemon. When the TextField is edited, update the filtered list with the new query.
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                    .onChange(of: searchQuery) { old, new in
                        pokemonList.updateFilteredList(with: new)
                    }
                    .autocorrectionDisabled(true)
            }
            
            // As it could take some time for the list of Pokemon to load, inform the user that the list is loading.
            if isLoading {
                VStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
            } else {
                List($pokemonList.filteredPokemonNames, id: \.self) { $pokemonName in
                    // Each Pokemon shows up as a Button such that when the Pokemon is pressed, its data is obtained from PokeAPI and a Pokemon Object is created using this data. This newly created Pokemon is then added to the users full Pokemon list and then takes them back to the HomeView.
                    Button(action: {
                        Task {
                            let pokemonData = await pokemonList.getPokemonData(pokemonName: pokemonName)
                            if let pokemonData = pokemonData {
                                let newPokemon = Pokemon(pokemonData: pokemonData)
                                userPokemon.addPokemon(newPokemon: newPokemon)
                            }
                            dismiss()
                        }
                    }) {
                        HStack {
                            AsyncImage(url: getSpriteUrl(pokemonName: pokemonName)) 
                            Text(Pokemon.format(name: pokemonName))
                                .font(.headline)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .padding()
        .onAppear(perform: {
            Task {
                // Upon View startup, the full list of Pokemon names should be fetched from the API.
                if let pokemonNames = await pokemonList.fetchPokemonList() {
                    pokemonList.loadPokemonList(nameToId: pokemonNames)
                }
                isLoading = false
            }
        })
        .accentColor(.black)
    }
    
    // As the Pokemon sprite URL is always obtained from the raw GitHub user content URL, we can get the sprite directly from there instead without needing to call the API. Every Pokemon should in theory have this sprite, but if not, then return nil and do not crash the application.
    private func getSpriteUrl(pokemonName: String) -> URL? {
        guard let pokemonApiNum = pokemonList.getPokemonApiNum(pokemonName: pokemonName) else {
            return nil
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonApiNum).png")
    }
}
