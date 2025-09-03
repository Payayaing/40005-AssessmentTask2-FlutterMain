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
                Text("I'm crashing out")
                    .font(.largeTitle)
                    .bold()
                List {
                    ForEach($userPokemon.userPokemon, id: \.pokemonData.name) { $pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: $pokemon)) {
                            HStack {
                                AsyncImage(url: pokemon.pokemonData.sprite)
                                
                                if pokemon.nickname == pokemon.pokemonData.name {
                                    Text(pokemon.nickname)
                                } else {
                                    Text("\(pokemon.nickname) (\(pokemon.pokemonData.name))")
                                }
                                Spacer()
                                Image(systemName: pokemon.isFavourite ? "star.fill" : "star")
                            }
                        }
                    }
                    .onDelete(perform: userPokemon.deletePokemon)
                }
                NavigationLink("Add New Pokemon", destination: SelectorView(userPokemon: userPokemon))
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
