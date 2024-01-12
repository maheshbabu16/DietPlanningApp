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
    var body: some Scene {
        WindowGroup {
            TabListView()
                .modelContainer(for: DietData.self)
        }
    }
}
