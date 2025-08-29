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
    
    @State var isLoading = true
    
    var body: some View {
        VStack {
            Text("Select A Pokemon")
                .font(.title)
                .padding()
            
            if isLoading {
                VStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
            } else {
                List(viewModel.pokemonNames, id: \.self) { pokemonName in
                    Button(action: {
                        
                    }) {
                        HStack {
                            AsyncImage(url: getSpriteUrl(pokemonName: pokemonName))
                            Text(pokemonName.capitalized)
                        }
                    }
                }
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
