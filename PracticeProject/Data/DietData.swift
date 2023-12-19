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
    
    
    init(userName: String = "",passWord: String = "",name: String = "", calories: Int = 1, quantity: Int = 1, protien: Int = 1, carbs: Int = 1, fats: Int = 1, calCount: Int = 1, protienCount: Int = 1, carbsCount: Int = 1, fatsCount: Int = 1) {
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
    }
}
