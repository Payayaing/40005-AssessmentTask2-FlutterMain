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
            
            TextField("Search", text: $searchQuery)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onChange(of: searchQuery) { old, new in
                    pokemonList.updateFilteredList(with: new)
                }
                .autocorrectionDisabled(true)
            
            if isLoading {
                VStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
            } else {
                List($pokemonList.filteredPokemonNames, id: \.self) { $pokemonName in
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
                            Text(pokemonName.capitalized)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: {
            Task {
                if let pokemonNames = await pokemonList.fetchPokemonList() {
                    pokemonList.loadPokemonList(names: pokemonNames)
                }
                isLoading = false
            }
        })
    }
    
    private func getSpriteUrl(pokemonName: String) -> URL? {
        guard let pokemonDexNum = pokemonList.getPokemonDexNum(pokemonName: pokemonName) else {
            return nil
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonDexNum).png")
    }
}
