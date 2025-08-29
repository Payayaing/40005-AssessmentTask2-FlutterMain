//
//  SelectorViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

class SelectorViewModel: ObservableObject {
    @Published var pokemonNames: [String] = []
    @Published var filteredPokemonNames: [String] = []
    
    func loadPokemonList() async {
        let decoder = JSONDecoder()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10000&offset=0")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(PokemonList.self, from: data)
            self.pokemonNames = response.results.map{ $0.name }
            self.filteredPokemonNames = response.results.map { $0.name }
        } catch {
            print("Failed to load Pokemon list: \(error)")
        }
    }
    
    func fetchPokemonList() -> [String] {
        return self.pokemonNames
    }
    
    func getPokemonDexNum(pokemonName: String) -> Int? {
        guard let index = self.pokemonNames.firstIndex(of: pokemonName) else {
            return nil
        }
        return index + 1
    }
}
