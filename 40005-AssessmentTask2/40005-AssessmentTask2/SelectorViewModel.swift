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
    let decoder = JSONDecoder()
    
    func loadPokemonList() async {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1025&offset=0")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(PokemonList.self, from: data)
            self.pokemonNames = response.results.map{ $0.name }
            self.filteredPokemonNames = response.results.map { $0.name }
        } catch {
            print("Failed to load Pokemon list: \(error)")
        }
    }
    
    func getPokemonData(pokemonName: String) async -> PokemonData? {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(PokemonData.self, from: data)
            return response
        } catch {
            print("Failed to load Pokemon data: \(error)")
            return nil
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
