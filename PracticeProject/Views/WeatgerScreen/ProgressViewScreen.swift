//
//  ProgressViewScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 26/11/23.
//

import SwiftUI

struct ProgressViewScreen: View {
    var body: some View {
        ZStack{
            Color.textColor.opacity(0.5)
                .ignoresSafeArea()
            ZStack{
                Color.black
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
            }.frame(width: 80,height: 80)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ProgressViewScreen()
}
