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
    
    @State var showsAlert = false
    @State var showsLogOutAlert = false
    @State var showProgress = false
    @State var isPrivate: Bool = false
    @State private var profileImageSize = false
    @State fileprivate var shouldRedirectToLogIn = false
    @State fileprivate var reportIssue: Bool = false
    @State fileprivate var isNotificationsEnabled: Bool = false
    @State var profileUsername: String = ""
    @State private var fontSize: CGFloat = 5
    @State private var deviceAppearance: AppearnaceStyle = .automatic
    @State private var changeAppIcon = ""
    @State private var editSheetPresented : Bool = false
    @State private var showChangePasswordSheet : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var dataFromDataBase
    @Query(filter: #Predicate<DietData> { data in
        data.isLogInApproved == true
    }) var calDataBase: [DietData]
    
    enum AppearnaceStyle {
        case automatic
        case light
        case dark
        
        var systemAppearance: UIUserInterfaceStyle{
            
            switch self {
            case .automatic:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
        
        func applyAppearance() {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = self.systemAppearance
            }
        }
    }
    
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
                                Text("\(calDataBase[0].name)")
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(.leading)
                                Spacer()
                                Button{
                                    self.profileUsername = calDataBase[0].name
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
                                Toggle("Notifications", isOn: $isNotificationsEnabled).foregroundStyle(Color("TextColor")).font(.system(size: 14))
                            }
                        }header: {
                            HStack{
                                Image(systemName: "bell.badge")
                                Text("Notifications")
                            }
                        }
                        
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
                                Image(systemName: "lock")
                                Toggle("Make account Private", isOn: $isPrivate).foregroundStyle(Color("TextColor")).font(.system(size: 14))
                            }
                        }header: {
                            Text("Account")
                        }
                        
                        //MARK: - Device Section
                        Section{
                            
                            HStack{
                                Image(systemName: "moonphase.first.quarter")
                                Picker("Appearnace", selection: $deviceAppearance){
                                    Text("Auto").tag(AppearnaceStyle.automatic)
                                    Text("Light").tag(AppearnaceStyle.light)
                                    Text("Dark").tag(AppearnaceStyle.dark)
                                }.font(.system(size: 14))
                            }
                            
                            HStack{
                                Image(systemName: "square.dashed.inset.filled")
                                Picker("Select icon", selection: $activeAppIcon) {
                                    let customIcons: [String] = ["AppIcon", "BallIcon", "OrangeIcon"]
                                    ForEach(customIcons, id: \.self){ i in
                                        HStack{
                                            Image("IconApp").resizable().frame(width: 30, height: 30)
                                            Text("\(i)")
                                        }
                                        .tag(i)
                                    }
                                }.pickerStyle(NavigationLinkPickerStyle())
                                
                            }
                            
                        } header: {
                            HStack{
                                Image(systemName: "ipad.and.iphone")
                                Text("Appearance")
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
                                    Image(systemName: "arrow.backward.circle")
                                    Text("Log Out")
                                }.foregroundStyle(Color.btnGradientColor)
                                
                            }.alert(isPresented: $showsLogOutAlert) {
                                Alert(title: Text("Log Out"), message: Text("Click yes if you wish to logout"), primaryButton: .destructive(Text("Log Out"),
                                     action: {
                                    calDataBase[0].isLogInApproved = false
                                    shouldRedirectToLogIn = true
                                }), secondaryButton: .cancel())
                            }
                            
                            Button{
                                self.showsAlert = true
                            } label: {
                                HStack{
                                    Image(systemName: "trash")
                                    
                                    Text("Delete my account")
                                }.foregroundStyle(Color.red)
                            }.alert(isPresented: $showsAlert) {
                                
                                if (calDataBase.count > 0){
                                    Alert(title: Text("Confirm"),
                                          message: Text("This deletes all your data"),
                                          primaryButton: .destructive(
                                            Text("Delete"),
                                            action: {
                                                deleteAccountAction()
                                            }
                                          ),
                                          secondaryButton: .cancel())
                                }else{
                                    Alert(title: Text("No data Found"),
                                          message: Text("You haven't added any data yet!"),
                                          dismissButton: .default(Text("Ok"), action: {
                                        self.showsAlert = false
                                    })
                                    )
                                }
                                
                                
                            }
                            
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
                                Text("Delete Database")
                                    .foregroundStyle(Color.btnGradientColor)
                            }
                        }header: {
                            Image(systemName: "tray.full")
                            Text("DataBase")
                        }
                    }
                    .navigationTitle("Settings")
                    .onChange(of: deviceAppearance) { _ in
                        // Apply appearance changes when the selected style changes
                        deviceAppearance.applyAppearance()
                    }
                }.sheet(isPresented: $editSheetPresented) {
                    ChangePasswordView(textFeildStr: $profileUsername, editButtonClicked: {
                        if profileUsername != calDataBase[0].name && profileUsername != ""{
                            calDataBase[0].name = profileUsername
                        }
                        self.editSheetPresented.toggle()
                    }, sheetType: .editUserName)
                    .presentationDetents([.medium, .large])
                }
                .sheet(isPresented: $showChangePasswordSheet) {
                    ChangePasswordView(textFeildStr: .constant(""), editButtonClicked: {
                        
                        self.showChangePasswordSheet.toggle()
                    }, sheetType: .changePassword)
                    .presentationDetents([.medium, .large])                }
            }
        }.onChange(of: activeAppIcon) { newIcon in
            UIApplication.shared.setAlternateIconName(newIcon)
        }
    }
    
    //MARK: - Function meathods.
    func deleteAccountAction(){
        
        do {
            try dataFromDataBase.delete(model: DietData.self, where: #Predicate { data in
                data.isLogInApproved == true
            })
            shouldRedirectToLogIn = true
        } catch {
            print("Failed to delete account.")
        }
        
        func deleteDataBase(){
            do {
                try dataFromDataBase.delete(model: DietData.self) } catch { print("Failed to clear all data.") }
        }
    }
}

#Preview {
    SettingsView()
}
