//
//  PokemonList.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI
import Foundation

// PokemonName Array Wrapper, which contains the Pokemon name and the URL to obtain the Pokemon's API ID from (to get the correct sprite). This Wrapper is used for the SelectorView and SelectorViewModel, which displays a list of Pokemon names for the user to select from.
struct PokemonList: Codable {
    let results: [PokemonNames]
}

struct PokemonNames: Codable {
    let name: String
    let url: String
}
