//
//  SelectorView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct SelectorView: View {
    
    @State var searchPokemon: String = ""
    @StateObject private var viewModel = SelectorViewModel()
    @Binding var userPokemon: [Pokemon]
    @State var pokemonNameList: [String] = []
    @Environment(\.dismiss) var dismiss
    @State var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                VStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
            } else {
                List(viewModel.pokemonNames, id: \.self) { pokemonName in
                    Button(action: {
                        Task {
                            let pokemonData = await viewModel.getPokemonData(pokemonName: pokemonName)
                            if let pokemonData = pokemonData {
                                userPokemon.append(Pokemon(pokemonData: pokemonData))
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
                .searchable(text: $searchPokemon)
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.loadPokemonList()
                pokemonNameList = viewModel.fetchPokemonList()
                isLoading = false
            }
        })
    }
    
    private func getSpriteUrl(pokemonName: String) -> URL? {
        guard let pokemonDexNum = viewModel.getPokemonDexNum(pokemonName: pokemonName) else {
            return nil
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonDexNum).png")
    }
}
