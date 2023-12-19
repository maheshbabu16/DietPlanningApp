//
//  ContentView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            ListHomeScreen()
                .tabItem {
                    Label("Appetite", systemImage: "fork.knife.circle")
                }.tag(0)
            CalculationView()
                .tabItem {
                    Label("Count Calories", systemImage: "square.grid.3x3.middleleft.fill")
                }.tag(1)
            WeatherView()
                .tabItem {
                    Label("Favourites", systemImage: "heart")
                }.tag(2)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }.tag(3)
        }.accentColor(Color("neonClr"))
            .onChange(of: selectedTab) { newValue in
                CommonFunctions.Functions.getHapticFeedback()
            }
            
    }
}

#Preview {
    ContentView()
}


