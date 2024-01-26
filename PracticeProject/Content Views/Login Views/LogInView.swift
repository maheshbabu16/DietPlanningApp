//
//  LogInView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 19/12/23.
//

import SwiftUI
import SwiftData

struct LogInView: View {
    @Environment(\ .modelContext) var logInInfo
    @Query var arrSignUpUserData: [DietData]
    
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
                    
                    Button{
                        if checkLogIn() {
                            allowLogIn = true
                            CommonFunctions.Functions.getHapticFeedback(impact: .light)
                        } else {
                            showsAlert = true
                            CommonFunctions.Functions.getHapticFeedback(impact: .heavy)

                        }
                        
                    }label: {
                        Text("Login")
                            .foregroundStyle(Color.textColor)
                            .font(.system(size: 20))
                            .bold()
                    }
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
                    
                    HStack(spacing: 10){
                        Button{
                            CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
                        }label: {
                            HStack{
                                Image(systemName: "apple.logo")
                                Text("Sign In With Apple")
                                    .font(.system(size: 14))
                            }.foregroundStyle(Color.black)
                            
                        }.frame(width:170, height: 50)
                            .background(Color.white)
                            .cornerRadius(10).padding(.top, 20.0)
                        Button{
                            CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
                        }label: {
                            HStack{
                                Image("google.logo").resizable()
                                    .frame(width: 20, height: 20)
                                Text("Sign In With Google")
                                    .font(.system(size: 14))
                            }.foregroundStyle(Color.black)
                                .padding(.horizontal, 5.0)
                        }.frame(width:170, height: 50)
                            .background(Color.white)
                            .cornerRadius(10).padding(.top, 20.0)
                    }
                    .padding(.top, 10.0)
                }
                NavigationLink(destination: TabListView(), isActive: $allowLogIn){ EmptyView() }
                
            }.navigationTitle("Log In")
        }
        
    }
    
    func checkLogIn() -> Bool{
            
            let arrFilter = arrSignUpUserData.filter({$0.name == txtUserName && $0.passWord == txtPassWord})
            if arrFilter.count > 0 {
                /// if all data are matched then will return true
                arrFilter[0].isLogInApproved = true
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
