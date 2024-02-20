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
    @AppStorage("active_icon") var activeAppIcon : String = "AppIcon"
    @StateObject var notificationManager = NotificationManager()
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var dataFromDataBase
    @Query(filter: #Predicate<UserDataModel> { data in
        data.isLoginApproved == true
    }) var userDataM: [UserDataModel]
    
    @State var deleteAccountAlert = false
    @State var showsLogOutAlert = false
    
    @State var isPrivate: Bool = false
    @State fileprivate var reportIssue: Bool = false
    
    @State fileprivate var isNotificationsEnabled: Bool = false
    
    @State fileprivate var shouldRedirectToLogIn = false
    @State private var editSheetPresented : Bool = false
    @State private var showChangePasswordSheet : Bool = false
    
    @State var deviceAppearanceImage : String = ""
    @State var profileUsername: String = ""
    @State var lockIconStr : String = ""
    @State var strUserName : String = ""
    
    @State private var fontSize: CGFloat = 5
    @State private var deviceAppearance: UIUserInterfaceStyle = .unspecified
    
    //MARK: - Body for main view
    var body: some View {
        
        //MARK: - NavigationStack
        NavigationStack{
            if shouldRedirectToLogIn {
                SplashScreen()
            } else {
                ZStack{
                    List {
                        
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
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.blue.opacity(0.25))
                                        Image(systemName: "pencil").foregroundStyle(Color.primary)
                                    }
                                    .frame(width: 40 ,height: 40)
                                }
                            }.padding(.vertical, 5)
                            
                            
                        }
                    header: {
                        HStack{
                            Image(systemName: "person.fill")
                            Text("Profile")
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
                                        }else {
                                            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                                                UIApplication.shared.open(appSettings)
                                            }
                                        }
                                        
                                    })
                                    .task {
                                        await notificationManager.getAuthorisationStatus()
                                    }
                                    .foregroundStyle(Color("TextColor"))
                                    .font(.system(size: 14))
                                
                            }
                        }header: {}
                        
                        
                        //MARK: - Account Section
                        Section{
                            
                            HStack {
                                Button{
                                    self.showChangePasswordSheet.toggle()
                                }label: {
                                    Image(systemName: "key.radiowaves.forward").foregroundStyle(Color.blue)
                                }
                                Text("Change Password")
                                    .font(.system(size: 14))
                            }
                            HStack{
                                Image(systemName: "\(lockIconStr)")
                                Toggle(isOn: $isPrivate) {
                                    Text("Private account")
                                        .foregroundStyle(Color.textColor)
                                        .font(.system(size: 14))
                                    
                                }.onChange(of: isPrivate) { newValue in
                                    withAnimation(.smooth) {
                                        lockIconStr = newValue ? "lock" : "lock.open"
                                    }
                                }
                            }
                        }header: {
                            Text("Account")
                        }
                        
                        //MARK: - Apperance Section
                        Section{
                            
                            HStack{
                                Image(systemName: "\(deviceAppearanceImage)").foregroundStyle(Color.blueYellowGradient)
                                Picker(selection: $deviceAppearance) {
                                    
                                    Text("Auto").tag(UIUserInterfaceStyle.unspecified)
                                    Text("Light").tag(UIUserInterfaceStyle.light)
                                    Text("Dark").tag(UIUserInterfaceStyle.dark)
                                    
                                } label: {
                                    Text("Appearnace").font(.system(size: 14))
                                }
                            }
                            
                            HStack{
                                HStack{
                                    Image(systemName: "square.dashed").font(.system(size: 14))
                                    Text("Select Icon").font(.system(size: 14))
                                }
                                Spacer()
                                
                                Menu {
                                  Text("Choose Icon")
                                    Picker(selection: $activeAppIcon) {
                                        
                                        HStack{
                                            Image("IconApp").resizable().frame(width: 30, height: 30)
                                            Text("Original")
                                        }.tag("AppIcon")
                                        
                                        HStack{
                                            Image("pIcon").resizable().frame(width: 30, height: 30)
                                            Text("P Icon")
                                        }.tag("AppIcon2")
                                        
                                        HStack{
                                            Image("rainbow").resizable().frame(width: 30, height: 30)
                                            Text("Rainbow Icon")
                                        }.tag("AppIcon3")
                                        
                                    } label: {
                                        Text("Select icon")
                                    }.pickerStyle(InlinePickerStyle())
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 20))
                                        .foregroundStyle(Color.red)
                                }
                            }
                        }header: {
                            HStack{
                                Image(systemName: "ipad.and.iphone")
                                Text("Device")
                            }
                        }
                        
                        //MARK: - Help Section
                        Section{
                            
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
                            
                            HStack{
                                HStack{
                                    Image(systemName: "waveform")
                                    Text("Version").font(.system(size: 14))
                                }
                                Spacer()
                                Text("1.0.0").font(.system(size: 14))
                            }
                        }header: {
                            HStack{
                                Image(systemName: "externaldrive.badge.exclamationmark")
                                Text("Help")
                            }
                        }
                        
                        //MARK: - Credentials Section
                        Section{
                            
                            Button{
                                self.showsLogOutAlert = true
                            }label: {
                                HStack{
                                    Image(systemName: "arrow.backward.circle").foregroundStyle(Color.btnGradientColor)
                                    Text("Log Out")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.primary)
                                }
                                
                            }.alert(isPresented: $showsLogOutAlert) {
                                Alert(title: Text("Log Out"), message: Text("Click yes if you wish to logout"), primaryButton: .destructive(Text("Log Out"),
                                                                                                                                            action: {
                                    userDataM[0].isLoginApproved = false
                                    shouldRedirectToLogIn = true
                                }), secondaryButton: .cancel())
                            }
                            
                            Button{
                                self.deleteAccountAlert = true
                            } label: {
                                HStack{
                                    Image(systemName: "shared.with.you.slash").foregroundStyle(Color.red)
                                    Text("Delete my account")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.primary)
                                }
                            } .confirmationDialog("This action deletes your account from database!!!", isPresented: $deleteAccountAlert, titleVisibility: .visible, actions: {
                                Button {
                                    self.showsLogOutAlert = true
                                } label: {
                                    Text("Log out instead")
                                }
                                
                                Button("Erase account", role: .destructive) {
                                    self.deleteAccountAction()
                                }
                            })
                            
                        }header: {
                            HStack{
                                Image(systemName: "key.viewfinder")
                                Text("Credentials")
                            }
                        }
                        
                        //MARK: - Database Section
                        Section{
                            Button{
                                
                            }label: {
                                HStack{
                                    Image(systemName: "trash")
                                    Text("Clear Database")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.btnGradientColor)
                                }
                            }
                        }header: {
                            HStack{
                                Image(systemName: "tray.full")
                                Text("DataBase")
                            }
                        }
                    }
                    .navigationTitle("Settings")
                    .onChange(of: deviceAppearance) { appearnce in
                        
                        withAnimation {
                            // Apply appearance changes when the selected style changes
                            if deviceAppearance == .unspecified {
                                deviceAppearanceImage = "livephoto.badge.automatic"
                            } else if deviceAppearance == .light {
                                deviceAppearanceImage = "sun.min"
                            }else if deviceAppearance == .dark {
                                deviceAppearanceImage = "moon.stars"
                            }
                        }
                            UIApplication.shared.windows.forEach { window in
                                window.overrideUserInterfaceStyle = appearnce
                            }
                    }
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
                .sheet(isPresented: $showChangePasswordSheet) {
                    ChangePasswordView(textFeildStr: .constant(""), editButtonClicked: {
                        
                        self.showChangePasswordSheet.toggle()
                    }, sheetType: .changePassword)
                    .presentationDetents([.medium, .large])                }
            }
        }.onChange(of: activeAppIcon, perform: { newIcon in
            UserDefaults.standard.setValue(newIcon, forKey: "active_icon")
            UIApplication.shared.setAlternateIconName(newIcon)
        })
        .onAppear {
            isNotificationsEnabled = notificationManager.permissionsEnabled
            strUserName = userDataM.count > 0 ? userDataM[0].name : "Your name displays here"
            deviceAppearanceImage = "livephoto.badge.automatic"
            lockIconStr = isPrivate ? "lock" : "lock.open"
        }
    }
    
    //MARK: - Function meathods.
    func deleteAccountAction(){
        
        do {
            try dataFromDataBase.delete(model: UserDataModel.self, where: #Predicate { data in
                data.isLoginApproved == true
            })
            shouldRedirectToLogIn = true
        } catch {
            print("Failed to delete account.")
        }
        
        func deleteDataBase(){
            do { try dataFromDataBase.delete(model: UserDataModel.self) } catch { print("Failed to clear all data.") } }
    }
}

#Preview {
    SettingsView()
}
