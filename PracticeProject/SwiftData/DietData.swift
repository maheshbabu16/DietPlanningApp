//
//  DietData.swift
//  PracticeProject
//
//  Created by Mahesh babu on 22/11/23.
//

import Foundation
import SwiftData

@Model
class DietData {
    var userName: String
    var passWord: String
    var name: String
    var calories: Int
    var quantity: Int
    var protien: Int
    var carbs: Int
    var fats: Int
    var calCount: Int
    var protienCount: Int
    var carbsCount: Int
    var fatsCount: Int
    var isLogInApproved : Bool
    
    
    init(userName: String = "",passWord: String = "",name: String = "", calories: Int = 0, quantity: Int = 0, protien: Int = 0, carbs: Int = 0, fats: Int = 0, calCount: Int = 0, protienCount: Int = 0, carbsCount: Int = 0, fatsCount: Int = 0, isLogInApproved: Bool = false) {
        self.userName = userName
        self.passWord = passWord
        self.name = name
        self.calories = calories
        self.quantity = quantity
        self.protien = protien
        self.carbs = carbs
        self.fats = fats
        self.calCount = calCount
        self.protienCount = protienCount
        self.carbsCount = carbsCount
        self.fatsCount = fatsCount
        self.isLogInApproved = isLogInApproved
    }
}
