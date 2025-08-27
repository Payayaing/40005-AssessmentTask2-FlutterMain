//
//  SelectorView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//

import SwiftUI

struct SelectorView: View {
    @Binding var allPokemon: [Pokemon]
    @State var searchPokemon: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            TextField(
                "Search for a Pokemon",
                text: $searchPokemon
            )
            List {
                
            }
        }
        .padding()
    }
}
