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

class CommonFunctions{
    enum Functions{
        static func getHapticFeedback(impact: UIImpactFeedbackGenerator.FeedbackStyle) {
            let generator = UIImpactFeedbackGenerator(style: impact)
            generator.impactOccurred()
        }
        
    }
    
    static func isFaceIDSetupCompleted() -> Bool {
        if let available = UserDefaults.standard.object(forKey: "isFaceIDAvailable") as? Bool {
            return available
        }
        return false
    }
    
    struct ViewFunctions {
        static func editButtonView(heightWidth: CGFloat ) -> some View {
            ZStack {
                RoundedRectangle(cornerRadius: heightWidth / 2)
                    .fill(Color.blue.opacity(0.25))
                Image(systemName: "pencil").foregroundStyle(Color.primary)
            }
            .frame(width: heightWidth ,height: heightWidth)
        }
    }
}
