//
//  ContentView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI
import SwiftData

struct TabListView: View {
   
    //MARK: - Property Wrappers for variables
    @State private var selectedTab: Int = 0
    
    @Query(filter: #Predicate<UserDataModel> { data in
            data.isLoginApproved == true
        }) var userModel: [UserDataModel]
  
    
    //MARK: - Body view
    var body: some View {
        TabView(selection: $selectedTab){
            HomeListView(tabItemTag: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(0)
            CalculationView()
                .tabItem {
                    Label("Count Calories", systemImage: "fork.knife.circle")
                }.tag(1)
            SheduleWorkOutView()
                .tabItem {
                    Label("Shedule Workout", systemImage: "dumbbell")
                }.tag(2)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }.tag(3)
        }.background(.ultraThinMaterial)
        .onAppear(perform: {
            UserDefaults.standard.setValue(userModel[0].userID, forKey: "UserID")
        })
        .accentColor(Color.red)
        .onChange(of: selectedTab) { newValue in
            CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
        }
    }
}

#Preview {
    TabListView()
}


