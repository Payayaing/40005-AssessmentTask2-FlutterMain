//
//  HomeView.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 27/8/2025.
//
import SwiftUI

struct HomeView: View {
    @State var userPokemon: [Pokemon] = []
    @State var searchPokemon: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                List {
                    
                }
                .searchable(text: $searchPokemon, prompt: "Search for your Pokemon")
                .navigationTitle("Help me")
                NavigationLink("Add New Pokemon", destination: SelectorView(userPokemon: $userPokemon))
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
