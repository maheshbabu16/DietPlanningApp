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
    
    @StateObject var biometry = BiometryManager()
    @Environment(\.modelContext) var formData

    //MARK: - Body View
    
    var body: some View {
        ZStack{
            if biometry.isAuthenticated{
                TabListView().navigationBarBackButtonHidden()
            }else{
                if self.isSplashScreenActive {
                    if fetchDataBase.count > 0, fetchDataBase[0].isLoginApproved {
                        TabListView().navigationBarBackButtonHidden()
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
        }
        //MARK:  View will appear
        .onAppear {
            if isFaceIDSetupCompleted() {
                Task{
                    await biometry.startBiometryVerification()
                }
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        self.isSplashScreenActive = true
                    }
                }
            }
        }
    }
    
    func isFaceIDSetupCompleted() -> Bool {
        if let available = UserDefaults.standard.object(forKey: "isFaceIDAvailable") as? Bool {
            return available
        }
        return false
    }
}

#Preview {
    SplashScreen()
}
