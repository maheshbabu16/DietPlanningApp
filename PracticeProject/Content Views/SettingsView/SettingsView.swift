//
//  SettingsView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//
import SwiftData
import SwiftUI


struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
    
    
    var body: some View {
        NavigationView{
            
            if shouldRedirectToLogIn {
                SplashScreen()
            } else {
                ZStack{
                    List {
                        Section{
                            HStack {
                                Text("Mahesh")
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(.leading)
                                Spacer()
                                Button{
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
                        Section{
                            HStack {
                                Image(systemName: "key.radiowaves.forward").foregroundStyle(Color.blue)
                                Text("Change Password")
                            }
                            
                            HStack{
                                Image(systemName: "lock")
                                Toggle("Make account Private", isOn: $isPrivate).foregroundStyle(Color("TextColor"))
                            }
                        }header: {
                            Text("Account")
                        }
                        Section{
                            //                            Slider(value: $fontSize, in: 1...10)
                            
                            HStack{
                                Image(systemName: "moonphase.first.quarter")
                                Picker("Appearnace", selection: $deviceAppearance){
                                    Text("Auto").tag(AppearnaceStyle.automatic)
                                    Text("Light").tag(AppearnaceStyle.light)
                                    Text("Dark").tag(AppearnaceStyle.dark)
                                }
                            }
                            HStack{
                                Image(systemName: "bell.badge")
                                Toggle("Notifications", isOn: $isNotificationsEnabled).foregroundStyle(Color("TextColor"))
                            }
                            HStack{
                                HStack{
                                    Image(systemName: "waveform")
                                    Text("Version")
                                }
                                Spacer()
                                Text("1.0.0")
                            }
                            
                            
                        } header: {
                            HStack{
                                Image(systemName: "ipad.and.iphone")
                                Text("Device")
                            }
                        }
                        
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
                                }.pickerStyle(NavigationLinkPickerStyle())
                            }
                        }header: {
                            HStack{
                                Image(systemName: "exclamationmark.warninglight")
                                Text("Report")
                            }
                        }
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
                }
            }
            
        }
        
    }
    
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
