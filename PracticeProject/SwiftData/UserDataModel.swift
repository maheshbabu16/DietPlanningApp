//
//  UserDataModel.swift
//  PracticeProject
//
//  Created by Mahesh on 14/02/24.
//

import Foundation
import SwiftData

@Model
class UserDataModel{
    var userName: String
    var passWord: String
    var name: String
    var isLoginApproved : Bool 

    @Relationship(deleteRule: .cascade) 
    var userPrefrence :  UserPrefrences?
    var dietChart :  CalorieModel?
    var workoutChart :  SheduleWorkoutModel?
    
    init(userName: String, passWord: String, name: String, isLoginApproved: Bool = false, userPrefrence: UserPrefrences? = nil, dietChart: CalorieModel? = nil, workoutChart: SheduleWorkoutModel? = nil) {
        self.userName = userName
        self.passWord = passWord
        self.name = name
        self.isLoginApproved = isLoginApproved
        self.userPrefrence = userPrefrence
        self.dietChart = dietChart
        self.workoutChart = workoutChart
    }
}
