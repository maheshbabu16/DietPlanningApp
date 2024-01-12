//
//  SignUPScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 07/01/24.
//

import SwiftUI

struct SignUPScreen: View {
    
    @Environment (\.modelContext) var addLogInCredentials
    
    @State private var strNewUserName = ""
    @State private var strNewPassword = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    LoginTextFeildView(textFeildStr: $strNewUserName, placeHolder: "Create UserName")
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 5.0)
                    LoginTextFeildView(textFeildStr: $strNewPassword, placeHolder: "Create Password")
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 5.0)
                    Button{
                        if !(strNewPassword == "" && strNewUserName == ""){
                            addData()
                        }
                       
                    }label: {
                        Text("Sign Up")
                            .foregroundStyle(Color.textColor)
                            .font(.system(size: 20))
                            .bold()
                    }
                    .frame(width:200, height: 50)
                    .background(Color.btnGradientColor)
                    .cornerRadius(10).padding(.top, 20.0)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) { // <3>
                    Text("Create Your Credentials")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.btnGradientColor)
                    
                }
            }
        }
    }
    func addData() {
        let newData = DietData(
            userName: strNewUserName,
            passWord: strNewPassword,
            name: strNewUserName
        )
        withAnimation {
            addLogInCredentials.insert(newData)
            print("Data Saved")
        }
    }
    
}

#Preview {
    SignUPScreen()
}
