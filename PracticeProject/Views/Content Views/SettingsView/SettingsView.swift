//
//  SettingsView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//
import SwiftData
import SwiftUI


struct SettingsView: View {
    
    //MARK: - Property Wrappers for variables
    @StateObject var notificationManager = NotificationManager()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var dataFromDataBase
    @Query(filter: #Predicate<UserDataModel> { data in
        data.isLoginApproved == true
    }) var userDataM: [UserDataModel]
    
    @State var deleteAccountAlert = false
    @State var showsLogOutAlert = false
    
    @State fileprivate var reportIssue: Bool = false
    
    @State fileprivate var isNotificationsEnabled: Bool = false
    @State fileprivate var isFaceIDEnabled: Bool = false
    @State fileprivate var faceIDSetupSheet: Bool = false
    
    @State fileprivate var shouldRedirectToLogIn = false
    @State private var editSheetPresented : Bool = false
    @State private var showChangePasswordSheet : Bool = false
    @State private var changeAppIconSheet : Bool = false
    
    @State var deviceAppearanceImage : String = ""
    @State var profileUsername: String = ""
    @State var lockIconStr : String = ""
    @State var strUserName : String = ""
    
    @State private var fontSize: CGFloat = 5
    @State private var deviceAppearance: UIUserInterfaceStyle = .unspecified
    @StateObject var settingRow = SettingsViewMethods()
    
    var isLogInScreen : Bool = false
    //MARK: - Body for main view
    var body: some View {
        
        //MARK: - NavigationStack
        NavigationStack{
            if shouldRedirectToLogIn {
                SplashScreen()
            } else {
                ZStack{
                    List {
                        if !isLogInScreen{
                            //MARK: - Profile Section
                            Section{
                                HStack {
                                    Text("\(strUserName)")
                                        .minimumScaleFactor(0.1)
                                        .lineLimit(1)
                                        .font(.system(size: 25))
                                        .bold()
                                        .padding(.leading)
                                    Spacer()
                                    Button{
                                        self.profileUsername = userDataM[0].name
                                        self.editSheetPresented.toggle()
                                        CommonFunctions.Functions.getHapticFeedback(impact: .light)
                                    }label: {
                                        CommonFunctions.ViewFunctions.editButtonView(heightWidth: 40)
                                    }
                                }.padding(.vertical, 5)
                            }
                        header: {
                            HStack{
                                Image(systemName: "person.fill")
                                Text("Profile")
                            }
                        }
                        }
                        //MARK: - Notifications Section
                        Section{
                            HStack{
                                Image(systemName: "app.badge")
                                Toggle("Notifications", isOn: $isNotificationsEnabled)
                                    .onChange(of: isNotificationsEnabled, perform: { newValue in
                                        if newValue{
                                            Task{
                                                await notificationManager.request()
                                            }
                                        }else if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                                            UIApplication.shared.open(appSettings)
                                        }
                                    }).task {
                                        await notificationManager.getAuthorisationStatus()
                                    }
                                    .foregroundStyle(Color("TextColor"))
                                    .font(.system(size: 14))
                            }
                        }
                        
                        if !isLogInScreen{
                            //MARK: - Account Section
                            Section{
                                /// FaceID
                                settingRow.faceIDView(isFaceIDEnabled: isFaceIDEnabled)
                                    .onTapGesture {
                                        faceIDSetupSheet.toggle()
                                    } .onAppear(perform: {
                                        isFaceIDEnabled =  CommonFunctions.isFaceIDSetupCompleted()
                                    })
                                    .sheet(isPresented: $faceIDSetupSheet, content: {
                                        SetUpFaceIDView(isFaceIDAvailable: $isFaceIDEnabled) {
                                            faceIDSetupSheet.toggle()
                                        }
                                        .interactiveDismissDisabled()
                                    })
                                
                                ///Change password
                                settingRow.changePasswordView()
                                    .onTapGesture {
                                        self.showChangePasswordSheet.toggle()
                                    }
                                    .sheet(isPresented: $showChangePasswordSheet) {
                                        ChangePasswordView(textFeildStr: .constant(""), strPassword: userDataM[0].passWord, editButtonClicked: {
                                            self.showChangePasswordSheet.toggle()
                                        }, sheetType: .changePassword)
                                        .presentationDetents([.fraction(0.75), .large])
                                    }
                                
                                /// Delete account
                                settingRow.deleteAccountView()
                                    .onTapGesture {
                                        self.deleteAccountAlert = true
                                    }.confirmationDialog("This action deletes your account from database!!!", isPresented: $deleteAccountAlert, titleVisibility: .visible, actions: {
                                        Button {
                                            self.showsLogOutAlert = true
                                        } label: {
                                            Text("Log out instead")
                                        }
                                        
                                        Button("Erase account", role: .destructive) {
                                            UserDefaults.standard.removeObject(forKey: "UserLogIN")
                                            self.deleteAccountAction()
                                        }
                                    })
                            }header: {
                                Text("Account")
                            }
                        }
                        //MARK: - Device Section
                        Section{
                            
                            ///Device Appearance
                            HStack{
                                Image(systemName: "\(deviceAppearanceImage)").foregroundStyle(Color.blueYellowGradient)
                                Picker(selection: $deviceAppearance) {
                                    Text("Auto").tag(UIUserInterfaceStyle.unspecified)
                                    Text("Light").tag(UIUserInterfaceStyle.light)
                                    Text("Dark").tag(UIUserInterfaceStyle.dark)
                                } label: {
                                    Text("Appearnace").font(.system(size: 14))
                                }
                            }.onChange(of: deviceAppearance) { oldAppearnce, newAppearnce in
                                if newAppearnce != oldAppearnce {
                                    withAnimation { /// Apply appearance changes when the
                                        self.changeColorScheme(appearnce: newAppearnce)
                                    }
                                }
                            }
                            ///Change App Icon
                            settingRow.changeAppIconView()
                                .onTapGesture {
                                    self.changeAppIconSheet.toggle()
                                }
                            
                        }header: {
                            HStack{
                                Image(systemName: "ipad.and.iphone")
                                Text("Device")
                            }
                        }
                        
                        //MARK: - Help Section
                        Section{
                            
                            /// Tips
                            NavigationLink {
                                
                            } label: {
                                settingRow.tipsView()
                            }
                            
                            /// Write to us
                            HStack{
                                Image(systemName: "exclamationmark.bubble").foregroundStyle(Color.yellow)
                                Picker("Write To Us", selection: $reportIssue) {
                                    Text("Share screenshot")
                                    Text("Share a recording")
                                    Text("Write an email")
                                    Text("Report a crash")
                                    Text("Write feedback on Appstore")
                                    Text("Rate us on Appstore")
                                }.pickerStyle(NavigationLinkPickerStyle()).font(.system(size: 15))
                            }
                            
                        }header: {
                            HStack{
                                Image(systemName: "externaldrive.badge.exclamationmark")
                                Text("Help")
                            }
                        }
                        
                        ///App Version
                        settingRow.appVersionView()
                        
                        if !isLogInScreen{
                            //MARK: - LogOut Button
                            Section{
                                Button{
                                    self.showsLogOutAlert = true
                                }label: {
                                    settingRow.logoutView()
                                }.alert(isPresented: $showsLogOutAlert) {
                                    Alert(title: Text("Log Out"), message: Text("Click yes if you wish to logout"), primaryButton: .destructive(Text("Log Out"),
                                                                                                                                                action: {
                                        userDataM[0].isLoginApproved = false
                                        shouldRedirectToLogIn = true
                                        UserDefaults.standard.removeObject(forKey: "isFaceIDAvailable")
                                    }), secondaryButton: .cancel())
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .navigationTitle("Settings")
                }.sheet(isPresented: $editSheetPresented, onDismiss: {
                    strUserName = userDataM.count > 0 ? userDataM[0].name : "Your name displays here"
                }, content: {
                    ChangePasswordView(textFeildStr: $profileUsername, editButtonClicked: {
                        if profileUsername != userDataM[0].name && profileUsername != ""{
                            userDataM[0].name = profileUsername
                        }
                        self.editSheetPresented.toggle()
                    }, sheetType: .editUserName)
                    .presentationDetents([.medium, .large])
                })
                .sheet(isPresented: $changeAppIconSheet, onDismiss: {
                    
                }, content: {
                    ChangeAppIconScreen(tooggleSheet: $changeAppIconSheet)
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                })
            }
        }.onAppear {
            isNotificationsEnabled = notificationManager.permissionsEnabled
            strUserName = userDataM.count > 0 ? userDataM[0].name : "Your name displays here"
            deviceAppearanceImage = "livephoto.badge.automatic"
        }
    }
}

//MARK: - Function meathods.
extension SettingsView {
    
    func deleteAccountAction(){
        do {
            try dataFromDataBase.delete(model: UserDataModel.self, where: #Predicate { data in
                data.isLoginApproved == true
            })
            shouldRedirectToLogIn = true
        } catch {
            print("Failed to delete account.")
        }
    }
    
    func deleteDataBase(){
        do {
            try dataFromDataBase.delete(model: UserDataModel.self)
        } catch {
            print("Failed to clear all data.")
        }
    }
    
    func changeColorScheme(appearnce: UIUserInterfaceStyle){
        switch appearnce {
        case .light:
            deviceAppearanceImage = "sun.min"
            
        case .dark:
            deviceAppearanceImage = "moon.stars"
            
        default:
            deviceAppearanceImage = "livephoto.badge.automatic"
        }
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = appearnce
        }
    }
}
#Preview {
    SettingsView()
}
