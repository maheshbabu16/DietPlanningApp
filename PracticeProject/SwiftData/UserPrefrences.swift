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
    var darkModePreffered   : Bool
    var isAccountPrivate    : Bool
    @Attribute(originalName : "active_icon") var preferedAppIcon: String

    init(darkModePreffered: Bool, isAccountPrivate: Bool, preferedAppIcon: String) {
        self.darkModePreffered = darkModePreffered
        self.isAccountPrivate = isAccountPrivate
        self.preferedAppIcon = preferedAppIcon
    }
}
