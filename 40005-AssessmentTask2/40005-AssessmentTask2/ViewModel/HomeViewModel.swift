//
//  HomeViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 2/9/2025.
//

import SwiftUI

// HomeViewModel stores information pertaining to the Pokemon list on the HomeView. This allows for easy management by tracking a persistent list of Pokemon. This View Model also supports adding and deleting Pokemon.
class HomeViewModel: ObservableObject {
    @Published var userPokemon: [Pokemon] = []
    
    func addPokemon(newPokemon: Pokemon) {
        userPokemon.append(newPokemon)
    }
    
    func deletePokemon(at offsets: IndexSet) {
        userPokemon.remove(atOffsets: offsets)
    }
}
