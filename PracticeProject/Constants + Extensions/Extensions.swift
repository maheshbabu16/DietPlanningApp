//
//  Extensions.swift
//  PracticeProject
//
//  Created by Mahesh on 14/02/24.
//

import Foundation
import SwiftUI

extension Color {
    //Colors
    static let tabIconColor = Color("neonClr")
    static let textColor = Color("TextColor")
    static let mainColor = Color("MainColor")

    //Gradients
    static let btnGradientColor = LinearGradient(colors: [.blue, .pink], startPoint: .top, endPoint: .bottomTrailing)
    static let viewGradientColor = LinearGradient(colors: [.secondary.opacity(0.75), .green.opacity(0.75)], startPoint: .top, endPoint: .bottomTrailing)
    static let blueYellowGradient = LinearGradient(colors: [.blue, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let pinkYellowGradient = LinearGradient(colors: [.orange.opacity(0.15), .orange], startPoint: .top, endPoint: .bottom)
    static let pinkNeonGradient = LinearGradient(colors: [.blue.opacity(0.2), .blue], startPoint: .topLeading, endPoint: .bottom)


    
    static let textGradient = LinearGradient(colors: [.black, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let titleGradientColor = LinearGradient(colors: [.green, .blue], startPoint: .bottomLeading, endPoint: .topTrailing)
}
