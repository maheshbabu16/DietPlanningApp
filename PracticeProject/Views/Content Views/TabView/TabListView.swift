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
    @Namespace var profileAnimation
    
    @State private var selectedTab: Int = 0
    @State private var profileImageExpanded: Bool = false
    
    @Query(filter: #Predicate<UserDataModel> { data in
            data.isLoginApproved == true
        }) var userModel: [UserDataModel]
  
    //MARK: - Body view
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedTab){
                NavigationStack{
                    UserHomeScreen(tabItemTag: $selectedTab)
                        .navigationTitle("Home")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    withAnimation(.spring(.bouncy)) { profileImageExpanded.toggle() }
                                } label: {
                                    ZStack{
                                        Image("flower")
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .matchedGeometryEffect(id: "profileImageNew", in: profileAnimation)
                                    }.frame(maxWidth: 50, maxHeight: 50)
                                }
                            }
                        }
                }.tabItem { Label("Home", systemImage: "house") }.tag(0)
                CalculationView()
                    .tabItem { Label("Count Calories", systemImage: "fork.knife.circle") }.tag(1)
                
                SheduleWorkOutView()
                    .tabItem { Label("Shedule Workout", systemImage: "dumbbell") }.tag(2)
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }.tag(3)
                
            }.background(.ultraThinMaterial)
//                .onAppear(perform: { saveDataToUserDefaults() })
                .accentColor(Color.red)
                .onChange(of: selectedTab) {
                    CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
                }
            if profileImageExpanded{
                ZStack{
                    Image("flower")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .matchedGeometryEffect(id: "profileImageNew", in: profileAnimation)
                        .frame(maxWidth: 200, maxHeight: 200)
                }
//                .matchedGeometryEffect(id: "profileImageBackground", in: profileAnimation)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.thinMaterial)
                    .onTapGesture {
                        withAnimation(.spring(.bouncy)) {
                            profileImageExpanded.toggle()
                        }
                    }
            }
        }
    }
    
    func saveDataToUserDefaults(){
        UserDefaults.standard.setValue(userModel[0].userID, forKey: "UserID")
        if let user = UserDefaults.standard.object(forKey: "UserLogIN")as? Int{
            if user != 1 { UserDefaults.standard.setValue(0, forKey: "UserLogIN") }
        }else { UserDefaults.standard.setValue(0, forKey: "UserLogIN") }
    }
}

#Preview {
    TabListView()
}


