//
//  HomeView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

struct HomeView: View {
    @State var allPokemon: [Pokemon] = []
    @State var searchPokemon: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                List {
                    
                }
                .searchable(text: $searchPokemon)
                .navigationTitle("Help me")
                NavigationLink("Add New Pokemon", destination: SelectorView(allPokemon: $allPokemon))
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
