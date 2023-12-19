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
    
    
    
    //Gradients
    static let btnGradientColor = LinearGradient(colors: [.blue, .pink], startPoint: .top, endPoint: .bottomTrailing)
    static let viewGradientColor = LinearGradient(colors: [.secondary.opacity(0.75), .green.opacity(0.75)], startPoint: .top, endPoint: .bottomTrailing)
    
    static let textGradient = LinearGradient(colors: [.black, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
}


struct CommonFunctions{
    enum Functions{
    static func getHapticFeedback() {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
 
}
