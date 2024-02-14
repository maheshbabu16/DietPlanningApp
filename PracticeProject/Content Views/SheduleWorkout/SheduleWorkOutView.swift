//
//  SheduleWorkOutView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 07/02/24.
//

import SwiftUI

struct SheduleWorkOutView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Under Construction")
                    .font(.system(size: 20))
            }
            .navigationTitle("My Workout")
            .toolbar(){
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        
                    }label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundStyle(Color.btnGradientColor)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        
                    }label: {
                        Image(systemName: "plus.app")
                            .foregroundStyle(Color.btnGradientColor)
                    }
                }
            }
        }
    }
}

#Preview {
    SheduleWorkOutView()
}
