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

struct CommonFunctions {
    enum Functions {
        
        static func getHapticFeedback(impact: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.impactOccurred()
        }
    }
}
