//
//  PracticeProjectApp.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//
import SwiftData
import SwiftUI

@main
struct PracticeProjectApp: App {
    
    let container : ModelContainer
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }.modelContainer(container)
    }
    
    init() {
        let schema = Schema([UserDataModel.self])
        let config  = ModelConfiguration("UserDataModel", schema: schema)
        do{
            container = try ModelContainer(for: schema, configurations: config)
        } catch{
            fatalError("Something went wrong")
        }
    }
    
}
