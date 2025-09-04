//
//  SelectorViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

// This View Model controls the SelectorView by handling the necessary data types needed for the full Pokemon list.
class SelectorViewModel: ObservableObject, Filterable {
    
    // Not only are the Pokemon names needed for the list, a list of IDs (as Int) are needed as well. These IDs are used to specify the API endpoint needed for obtaining the Pokemon sprite. This dictionary allows for quick lookup of ID when given a Pokemon name.
    @Published var nameToId: [String : Int] = [:]
    
    // The list of Pokemon names is used as a reference point for the filtered list, allowing it to be easily reset to default state. This list can be filtered based on a user query. The filtered list is the list shown on the SelectorView.
    @Published var pokemonNames: [String] = []
    @Published var filteredPokemonNames: [String] = []
    
    // Defining a JSONDecoder to decode PokeAPI information used in the fetchPokemonList() and getPokemonData() async functions.
    let decoder = JSONDecoder()
    
    // Fetches the full Pokemon names and ID dictionary.
    func fetchPokemonList() async -> [String : Int]? {
        // Pokemon alternate forms should be included as some are crucial to builds (such as specific Arceus forms, Ogerpon forms, and etc.)
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20000&offset=0")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(PokemonList.self, from: data)
            
            // For each result in the Decoder response, check whether it should be excluded. If not, obtain the API ID from the URL and add these values in the dictionary. Then return this full dictionary.
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
    
    // After the full list is fetched, assigns the internal Published variables. As Dictionary types are unordered, it should be sorted by the API ID (in most cases, this corresponds to the Pokedex order).
    func loadPokemonList(nameToId: [String : Int]) {
        self.nameToId = nameToId
        
        let sortedPokemonNames = nameToId.sorted {$0.value < $1.value }.map { $0.key }
        self.pokemonNames = sortedPokemonNames
        self.filteredPokemonNames = sortedPokemonNames
    }

    // When provided a query String from the user, filter the full Pokemon list based on whether it contains the query string.
    func filterOn(_ searchText: String) -> [String] {
        if searchText.isEmpty {
            return self.pokemonNames
        } else {
            return self.pokemonNames.filter { Pokemon.format(name: $0).lowercased().contains(searchText.lowercased()) }
        }
    }

    // Linked to the TextField .onChange() listener.
    func updateFilteredList(with searchText: String) {
        self.filteredPokemonNames = filterOn(searchText)
    }
    
    // Fetch PokemonData depending on the Pokemon name. This is used to create Pokemon objects when interacting with the Pokemon names list. Every Pokemon in theory should have accessible PokemonData, but if not, do not crash the application.
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
    
    // Obtains the Pokemon's API number from the nameToId dictionary when provided its name.
    func getPokemonApiNum(pokemonName: String) -> Int? {
        guard let id = self.nameToId[pokemonName] else {
            return nil
        }
        return id
    }
}
