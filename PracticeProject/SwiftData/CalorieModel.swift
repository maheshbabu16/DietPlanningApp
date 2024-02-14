//
//  CalorieModel.swift
//  PracticeProject
//
//  Created by Mahesh on 14/02/24.
//

import Foundation
import SwiftData

@Model
class CalorieModel {
    var calories: Int
    var quantity: Int
    var protien: Int
    var carbs: Int
    var fats: Int
    var calCount: Int
    var protienCount: Int
    var carbsCount: Int
    var fatsCount: Int
    
    init(calories: Int, quantity: Int, protien: Int, carbs: Int, fats: Int, calCount: Int, protienCount: Int, carbsCount: Int, fatsCount: Int) {
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
