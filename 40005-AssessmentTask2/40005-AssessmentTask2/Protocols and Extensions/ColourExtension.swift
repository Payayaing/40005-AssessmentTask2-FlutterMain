//
//  ColourExtension.swift
//  40005-AssessmentTask2
//
//  Created by Bella on 3/9/2025.
//

import Foundation
import SwiftUICore

// Colour extension that allows a Color to be initialised using a hex code, allowing for increased
// colour flexibility and customisation options.
extension Color {
    static let primary: Color = .init(hex: 0x3b3b3b)
    
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: 1
        )
    }
}
