//
//  SheduleWorkoutModel.swift
//  PracticeProject
//
//  Created by Mahesh on 14/02/24.
//

import Foundation
import SwiftData

@Model
class SheduleWorkoutModel  {
    var day : String
    var workoutType : String
    
    init(day: String, workoutType: String) {
        self.day = day
        self.workoutType = workoutType
    }
}
