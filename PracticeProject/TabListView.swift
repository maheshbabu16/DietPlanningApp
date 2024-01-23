//
//  ContentView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct TabListView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            ListHomeScreen()
                .tabItem {
                    Label("Appetite", systemImage: "fork.knife.circle")
                }.tag(0)
            CalculationView()
                .tabItem {
                    Label("Count Calories", systemImage: "square.stack.3d.up")
                }.tag(1)
            MapTrackingView()
                .tabItem {
                    Label("Track Steps", systemImage: "figure.walk.motion")
                }.tag(2)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }.tag(3)
            
        }
        .accentColor(Color.red)
        .onChange(of: selectedTab) { newValue in
            CommonFunctions.Functions.getHapticFeedback()
        }
    }
}

#Preview {
    TabListView()
}


