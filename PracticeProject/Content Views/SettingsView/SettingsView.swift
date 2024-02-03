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
                                Spacer()
                                Button{
                                    CommonFunctions.Functions.getHapticFeedback(impact: .light)
                                }label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.textColor.opacity(0.15))
                                        Image(systemName: "pencil").foregroundStyle(Color.blue)
                                    }
                                    .frame(height: 40)
                                }
                                
                                
                            }.padding(.vertical, 10)
                            Toggle("Make account Private", isOn: $isPrivate).foregroundStyle(Color("TextColor"))
                            
                        }
                    header: {
                        Text("Profile")
                    }
                        Section{
                            Slider(value: $fontSize, in: 1...10)
                            Picker("Appearnace", selection: $deviceAppearance){
                                Text("Auto").tag(AppearnaceStyle.automatic)
                                Text("Light").tag(AppearnaceStyle.light)
                                Text("Dark").tag(AppearnaceStyle.dark)
                            }
                            
                            HStack{
                                Text("Version")
                                Spacer()
                                Text("1.0.0")
                            }
                           

                        } header: {
                            Text("System")
                        }
                        
                        Section("Report"){
                            Picker("Write To Us", selection: $reportIssue) {
                                Text("Send a screenshot")
                                Text("Write an email")
                                Text("Report a crash")
                                Text("Write feedback on ppstore")
                                Text("Rate us on Appstore")
                            }.pickerStyle(NavigationLinkPickerStyle())
                        }
                        Section("Credentials"){
                            Button{
                                self.showsLogOutAlert = true
                            }label: {
                                Text("Log Out")
                                    .foregroundStyle(Color.btnGradientColor)
                                
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
                                Text("Delete my account").foregroundStyle(Color.red)
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
                        }
                        
                        Section("DataBase") {
                            
                            Button{
                            }label: {
                                Text("Delete Database")
                                    .foregroundStyle(Color.btnGradientColor)
                            }
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
