//
//  HomeView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

struct HomeView: View {
    @State var userPokemon: [Pokemon] = []
    @State var searchPokemon: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("I'm crashing out")
                    .font(.largeTitle)
                    .bold()
                List {
                    ForEach(userPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            Text(pokemon.pokemonData.name)
                        }
                    }
                }
                NavigationLink("Add New Pokemon", destination: SelectorView(userPokemon: $userPokemon))
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
