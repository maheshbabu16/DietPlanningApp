//
//  Food.swift
//  ListPractice
//
//  Created by Mahesh babu on 05/11/23.
//

import Foundation

struct Food: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var description: String
    var isFavorite: Bool
    
    
    static func preview() -> [Food]{
        [
            Food(name: "Apple", icon: "🍎", description: "57", isFavorite: true),
            Food(name: "Banana", icon: "🍌", description: "134", isFavorite: false),
            Food(name: "Cherry", icon: "🍒", description: "87", isFavorite: false),
            Food(name: "Mango", icon: "🥭", description: "99", isFavorite: true),
            Food(name: "Kiwi", icon: "🥝", description: "110", isFavorite: false),
            Food(name: "Strawberry", icon: "🍓", description: "46", isFavorite: true),
            Food(name: "Grapes", icon: "🍇", description: "62", isFavorite: true),
            Food(name: "Rice", icon: "🍚", description: "130", isFavorite: true),
            Food(name: "Oats", icon: "🥣", description: "62", isFavorite: true)
        ]
    }
}

struct FoodCount: Identifiable {
    let id = UUID()
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
}

