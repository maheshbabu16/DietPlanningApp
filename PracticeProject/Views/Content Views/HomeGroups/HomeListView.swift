//
//  HomeListView.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI

struct HomeListView: View {
    var body: some View {
        NavigationStack{
            List{
                Section("New Items"){
                    
                }
                Section("For you"){
                    
                }
                Section("More..."){
                    
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeListView()
}
