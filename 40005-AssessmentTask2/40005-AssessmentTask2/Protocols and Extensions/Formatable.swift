//
//  Formatable.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 3/9/2025.
//

// Protocol to specify Objects that can be formatted. These Objects need to have both a static format method, which takes in a String, and an instance format method which takes no parameters. Both methods are needed here as the static method can just operate on the String, whereas the instance method is used to simplify syntax.
protocol Formatable {
    static func format(name: String) -> String
    func format() -> String
}
