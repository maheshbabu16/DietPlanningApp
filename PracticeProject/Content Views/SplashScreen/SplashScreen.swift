//
//  SplashScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI
import SwiftData

struct SplashScreen: View {
    
    @State var isActive: Bool = false
    
    @Query(filter: #Predicate<DietData> { data in
            data.isLogInApproved == true
        }) var fetchDataBase: [DietData]
    
    var body: some View {
        
        ZStack{
            if self.isActive {
                if fetchDataBase.count > 0 {
                    if fetchDataBase[0].isLogInApproved {
                        TabListView().navigationBarBackButtonHidden()
                    } else {
                        LogInView()
                    }
                } else {
                    LogInView()
                }
                
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
