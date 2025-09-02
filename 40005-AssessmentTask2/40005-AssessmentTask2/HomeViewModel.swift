//
//  HomeViewModel.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 2/9/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var userPokemon: [Pokemon] = []
    
    func addPokemon(newPokemon: Pokemon) {
        userPokemon.append(newPokemon)
    }
    
    func deletePokemon(at offsets: IndexSet) {
        userPokemon.remove(atOffsets: offsets)
    }
}
