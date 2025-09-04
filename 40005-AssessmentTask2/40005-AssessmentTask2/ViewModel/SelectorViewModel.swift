//
//  SelectorViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

class SelectorViewModel: ObservableObject, Filterable {
    @Published var nameToId: [String : Int] = [:]
    @Published var pokemonNames: [String] = []
    @Published var filteredPokemonNames: [String] = []
    
    let decoder = JSONDecoder()
    
    // Fetches the full Pokemon names list, and also assigns them the correct API ID so that the sprites
    // can be easily obtained.
    func fetchPokemonList() async -> [String : Int]? {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10000&offset=0")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(PokemonList.self, from: data)
            
            var nameToId: [String : Int] = [:]
            for result in response.results {
                if excludeResult(name: result.name) {
                    continue
                }
                if let idString = result.url.split(separator: "/").last, let id = Int(idString) {
                    nameToId[result.name] = id
                }
            }
            return nameToId
        } catch {
            print("Failed to load Pokemon list: \(error)")
            return nil
        }
    }
    
    // To reduce bloating of the full Pokemon list, redundant Pokemon forms or forms that cause errors
    // are removed from the full list. This includes G-Max forms, Minior forms, Miraidon + Koraidon forms,
    // as well as Pikachu cap forms.
    func excludeResult(name: String) -> Bool {
        let excludedResults = ["gmax", "meteor", "starter", "build", "mode", "cap"]
        // This falls under the cap excluded result, used for Pikachu forms. This needs to be correctly included.
        if name == "capsakid" {
            return false
        }
        return excludedResults.contains(where: name.contains)
    }
    
    // After the full list is fetched, assigns the internal Published variables.
    func loadPokemonList(nameToId: [String : Int]) {
        self.nameToId = nameToId
        
        let sortedPokemonNames = nameToId.sorted {$0.value < $1.value }.map { $0.key }
        self.pokemonNames = sortedPokemonNames
        self.filteredPokemonNames = sortedPokemonNames
    }

    func filterOn(_ searchText: String) -> [String] {
        if searchText.isEmpty {
            return self.pokemonNames
        } else {
            return self.pokemonNames.filter { Pokemon.format(name: $0).lowercased().contains(searchText.lowercased()) }
        }
    }

    func updateFilteredList(with searchText: String) {
        self.filteredPokemonNames = filterOn(searchText)
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
    
    func getPokemonApiNum(pokemonName: String) -> Int? {
        guard let id = self.nameToId[pokemonName] else {
            return nil
        }
        return id
    }
}
