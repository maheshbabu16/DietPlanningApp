//
//  ContentView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct TabListView: View {
   
    //MARK: - Property Wrappers for variables
    @State private var selectedTab: Int = 0
    
    //MARK: - Body view
    var body: some View {
        TabView(selection: $selectedTab){
            AppetiteHomeView()
                .tabItem {
                    Label("Appetite", systemImage: "fork.knife.circle")
                }.tag(0)
            CalculationView()
                .tabItem {
                    Label("Count Calories", systemImage: "takeoutbag.and.cup.and.straw")
                }.tag(1)
            SheduleWorkOutView()
                .tabItem {
                    Label("Shedule Workout", systemImage: "dumbbell")
                }.tag(2)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }.tag(3)
        }
        .accentColor(Color.red)
        .onChange(of: selectedTab) { newValue in
            CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
        }
    }
}

#Preview {
    TabListView()
}


