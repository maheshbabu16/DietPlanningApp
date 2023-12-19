//
//  WeatherView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 14/11/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        NavigationView{
            ZStack{
                ZStack{
                    Color.clear.opacity(0.5)
                        .ignoresSafeArea()
                    Text("Your favourites will be shown here.")
       
                }
            }
           
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    WeatherView()
}
