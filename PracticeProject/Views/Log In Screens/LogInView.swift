//
//  LogInView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 19/12/23.
//

import SwiftUI
import SwiftData

struct LogInView: View {
    @Query var accessUserDataBase: [DietData] = [DietData(userName: "Mahesh", passWord: "1234")]
    @Environment(\ .modelContext) var logInInfo
    
    @State private var txtUserName = ""
    @State private var txtPassWord = ""
    @State private var allowLogIn:Bool = false
    @State private var showsAlert:Bool = false
    @State var showProgress = false

    var body: some View {
      
            NavigationStack{
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
                        
                        HStack{
                            Spacer()
                            NavigationLink("Sign up ?", destination: SignUPScreen())
                                .padding(.trailing, 25.0).foregroundStyle(Color.btnGradientColor)
                        }
                        NavigationLink {
                            if (checkLogIn(strUserName: txtUserName, strPassWord: txtPassWord) == true){
                                ContentView()
                                    .navigationBarBackButtonHidden(true)
                            }
                        } label: {
                                Text("Login")
                                    .foregroundStyle(Color.textColor)
                                    .font(.system(size: 20))
                                    .bold()
                            }
                            
                            //                        Button{
                            //                            if (checkLogIn(strUserName: txtUserName, strPassWord: txtPassWord) == true){
                            //
                            //                                self.allowLogIn = true
                            //                                NavigationLink {
                            //                                    ContentView()
                            //                                } label: {
                            //                                ContentView()
                            //                                }
                            //
                            //                            } else {
                            //                                showsAlert = true
                            //                            }
                            //
                            //                        }label: {
                            //                            Text("Login")
                            //                                .foregroundStyle(Color.textColor)
                            //                                .font(.system(size: 20))
                            //                                .bold()
                            //                        }
                            .frame(width:200, height: 50)
                            .background(Color.btnGradientColor)
                            .cornerRadius(10).padding(.top, 20.0)
                            
                            .alert(isPresented: $showsAlert) {
                                
                                Alert(title: Text("Invalid Credentials"),
                                      message: Text("You haven't added any data yet!"),
                                      dismissButton: .default(Text("Ok"), action: {
                                    self.showsAlert = false
                                })
                                )
                            }
                        }
                }.navigationTitle("Log In")
            }
        
    }
    
    func checkLogIn(strUserName:String?, strPassWord:String?) -> Bool{
        if strUserName == "Mahesh" && strPassWord == "1234" {
            let newData = DietData(isLogInApproved: true)
            logInInfo.insert(newData)
            return true
        }
        return false
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
