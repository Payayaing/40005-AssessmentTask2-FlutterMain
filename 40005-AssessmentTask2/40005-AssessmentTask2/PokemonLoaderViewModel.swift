//
//  PokemonLoaderViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

class PokemonLoaderViewModel: ObservableObject {
    let decoder = JSONDecoder()
    func getData(speciesName: String) async -> PokemonData? {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(speciesName)")!
        let response = try? await URLSession.shared.data(from: url)
        guard let (data, _) = response else {
            return nil
        }
        let pokemonData = try? decoder.decode(PokemonData.self, from: data)
        guard let validData = pokemonData else {
            return nil
        }
        return validData
    }
}
