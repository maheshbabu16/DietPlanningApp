//
//  SignUPScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 07/01/24.
//

import SwiftUI
import SwiftData

struct SignUPScreen: View {
    
    //MARK: - Property Wrappers for variables
    @Environment (\.modelContext) var addLogInCredentials
    @State private var strNewUserName = ""
    @State private var strNewPassword = ""
    @State private var showAlert: Bool = false
    @State private var showMachingAlert: Bool = false
    @State private var presentSuccessScreen : Bool = false
    
    //MARK: - Body view
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.15))
                                .frame(maxHeight: 200)
                                .padding(.horizontal, 20)
                            VStack{
                                Image(systemName: "person.badge.plus")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(Color.brownBlackGradient)
                                
                                Text("Create your credentials")
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 5)
                                    .minimumScaleFactor(0.2)
                            }.padding(10)
                        }.padding(.top, 20)
                    Spacer()
                    
                    //MARK: - Username textfeild
                    LoginTextFeildView(textFeildStr: $strNewUserName, placeHolder: "Create UserName", textFeildType: .regular)
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                        .padding(.bottom, 5.0)
                    
                    //MARK: - Username textfeild
                    LoginTextFeildView(textFeildStr: $strNewPassword, placeHolder: "Create Password", textFeildType: .passwordFeild)
                        .frame(height: 60)
                        .padding(.horizontal, 20.0)
                    
                    Spacer()
                    //MARK: - Signup button
                    Button{
                        if !(strNewPassword == "" && strNewUserName == ""){
                            if !checkUserNameAlreadyExists(userName: strNewUserName){
                                addData()
                                presentSuccessScreen.toggle()
                            }else {
                                showMachingAlert = true
                            }
                        }
                        
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                            Text("Sign up")
                                .bold()
                                .foregroundStyle(Color.white)
                        }.frame(width: 200, height: 50)
                    }
                    Spacer()
                    
                }.blur(radius: presentSuccessScreen ? 3.0 : 0.0)
               
            }
            .alert("Select a diffrent User Name", isPresented: $showMachingAlert, actions: {
                
            })
            
            .fullScreenCover(isPresented: $presentSuccessScreen, content: {
                CheckMarkViewScreen {
                    presentSuccessScreen.toggle()
                }.cornerRadius(20).frame(height: 300)
                .presentationBackground(Color.clear)
            })
            //MARK: - Toolbar items
            .toolbar {
                ToolbarItem(placement: .principal) {
                    
                }
            }
        }
    }
    
    //MARK: - Add data function
    func addData() {
        let newData = UserDataModel(userID: UUID().uuidString, userName: strNewUserName, passWord: strNewPassword, name: strNewUserName, isLoginApproved: false)
        withAnimation {
            addLogInCredentials.insert(newData)
            CommonFunctions.Functions.getHapticFeedback(impact: .light)
            print("Data Saved")
        }
    }
    
    //MARK: - Check user already exists function
    func checkUserNameAlreadyExists(userName: String) -> Bool {
        
        let descriptor = FetchDescriptor<UserDataModel>(predicate: #Predicate { data in
            data.userName == userName
        })
        
        do {
            let fetchDataBase = try addLogInCredentials.fetch(descriptor)
            return fetchDataBase.count != 0 ? true : false
        }catch {
            
        }
        return false
    }
}

#Preview {
    SignUPScreen()
}
