//
//  Constants.swift
//  PracticeProject
//
//  Created by Mahesh babu on 14/11/23.
//

import Foundation
import UIKit
import SwiftUI


enum Constants {
    enum Text {
        static let foodTitle = "Food"
        static let addTitle = "Add an item"
        static let doneTitle = "Done"
        
    }
    
}
extension Color {
    //Colors
    static let tabIconColor = Color("neonClr")
    static let textColor = Color("TextColor")
    static let mainColor = Color("MainColor")

    //Gradients
    static let btnGradientColor = LinearGradient(colors: [.blue, .pink], startPoint: .top, endPoint: .bottomTrailing)
    static let viewGradientColor = LinearGradient(colors: [.secondary.opacity(0.75), .green.opacity(0.75)], startPoint: .top, endPoint: .bottomTrailing)
    
    static let textGradient = LinearGradient(colors: [.black, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let titleGradientColor = LinearGradient(colors: [.green, .blue], startPoint: .bottomLeading, endPoint: .topTrailing)
}


struct CommonFunctions{
    enum Functions{
        static func getHapticFeedback(impact: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.impactOccurred()
        }
    }
 
}
