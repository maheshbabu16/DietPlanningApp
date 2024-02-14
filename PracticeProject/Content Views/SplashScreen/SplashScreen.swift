//
//  SplashScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI
import SwiftData

struct SplashScreen: View {
    
    //MARK: - Property Wrappers for variables
    
    @State var isSplashScreenActive: Bool = false
    @Query(filter: #Predicate<UserDataModel> { data in
        data.isLoginApproved == true
    }) var fetchDataBase: [UserDataModel]
    
    //MARK: - Body View
    
    var body: some View {
        ZStack{
            if self.isSplashScreenActive {
                if fetchDataBase.count > 0 {
                    if fetchDataBase[0].isLoginApproved {
                        TabListView().navigationBarBackButtonHidden()
                        
                    } else { LogInView() }
                } else { LogInView() }
                
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
        
        //MARK:  View will appear
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.isSplashScreenActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
