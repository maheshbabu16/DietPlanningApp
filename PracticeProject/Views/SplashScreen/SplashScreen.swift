//
//  SplashScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false
    
    var body: some View {
        
        ZStack{
            if self.isActive {
                ContentView()
            } else {
                Color.black.ignoresSafeArea()
                VStack{
                    Image("IconApp")
                        .resizable()
                        .scaledToFit()
                    Text("Hola 👋").fontWeight(.medium)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 30))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


#Preview {
    SplashScreen()
}
