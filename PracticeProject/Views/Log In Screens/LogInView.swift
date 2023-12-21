//
//  LogInView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 19/12/23.
//

import SwiftUI
import SwiftData

struct LogInView: View {
    @Query var accessUserDataBase: [DietData]
    
    @State private var txtUserName = ""
    @State private var txtPassWord = ""
    @State private var allowLogIn:Bool = true
    
    var body: some View {
        if (allowLogIn == true){
            ContentView()
        }else{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    
                    LoginTextFeildView(textFeildStr: $txtUserName, placeHolder: "User Name")
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 5.0)
                    LoginTextFeildView(textFeildStr: $txtPassWord, placeHolder: "Password")
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 5.0)
                    
                    Button{
                        checkLogIn(strUserName: txtUserName, strPassWord: txtPassWord)
                    }label: {
                        Text("Login")
                            .foregroundStyle(Color.textColor)
                            .font(.system(size: 20))
                            .bold()
                    }.frame(width:200, height: 50)
                        .background(Color.btnGradientColor)
                        .cornerRadius(10).padding(.top, 50.0)
                }
            }
        }
    }
    
     func checkLogIn(strUserName:String?, strPassWord:String?){
         for item in accessUserDataBase {
             if strUserName == item.userName && strPassWord == item.passWord{
                 self.allowLogIn = true
            }
         }
    }
}

struct LoginTextFeildView: View {
    @Binding var textFeildStr: String
    var placeHolder: String
    
    
    var strUsername: String?
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.15))
            
            TextField("", text: $textFeildStr,
                      prompt: Text("\(placeHolder)")
                .foregroundStyle(Color.white)
                .font(.system(size: 15))
            )
            .padding()
            .foregroundStyle(Color.white)
        }
    }
}
#Preview {
    LogInView()
}
