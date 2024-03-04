//
//  UserPrefrences.swift
//  PracticeProject
//
//  Created by Mahesh on 14/02/24.
//

import Foundation
import SwiftData

@Model
class UserPrefrences {
    
    var userID : String
    var colorScheme   : Int
    var isAccountPrivate    : Bool
    @Attribute(originalName : "active_icon") var preferedAppIcon: String

    init(userID: String, colorScheme: Int, isAccountPrivate: Bool, preferedAppIcon: String) {
        self.userID = userID
        self.colorScheme = colorScheme
        self.isAccountPrivate = isAccountPrivate
        self.preferedAppIcon = preferedAppIcon
    }
}
