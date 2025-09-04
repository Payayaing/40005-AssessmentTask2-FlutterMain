//
//  Filterable.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 3/9/2025.
//

// Protocol to specify which Objects can be filtered. The filterOn method should take in a query String, and return an Array of strings which contain the query.
protocol Filterable {
    func filterOn(_: String) -> [String]
}
