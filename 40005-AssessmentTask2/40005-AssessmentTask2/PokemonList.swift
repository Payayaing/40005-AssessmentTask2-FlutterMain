//
//  PokemonList.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI
import Foundation

struct PokemonList: Codable {
    let results: [PokemonNames]
}

struct PokemonNames: Codable {
    let name: String
}
