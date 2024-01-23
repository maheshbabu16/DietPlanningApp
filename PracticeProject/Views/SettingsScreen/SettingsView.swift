//
//  SettingsView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//
import SwiftData
import SwiftUI


struct SettingsView: View {
    
    @State var showsAlert = false
    @State var showsLogOutAlert = false
    @State var showProgress = false
    
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
    
    @State var profileUsername: String = ""
    @State var isPrivate: Bool = true
    @State private var profileImageSize = false
    @State private var fontSize: CGFloat = 5
    @State private var deviceAppearance: AppearnaceStyle = .automatic
    
    @Environment(\.modelContext) var dataFromDataBase
    @Query var calDataBase: [DietData]
    
    var body: some View {
        NavigationView{
            ZStack{
                List {
                    Section{
                        TextField("Username", text: $profileUsername)
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
                    } header: {
                        Text("Appearnace")
                    }
                    Section{
                        HStack{
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                        }
                    } header: {
                        Text("About")
                    }
                    
                    Button{
                        self.showsLogOutAlert = true
                    }label: {
                        Text("Log Out")
                            .foregroundStyle(Color.btnGradientColor)
                        
                    }.alert(isPresented: $showsLogOutAlert) {
                        Alert(title: Text("Log Out"), message: Text("Click yes if you wish to logout"), primaryButton: .destructive(Text("Log Out"),
                                                                                                                                    action: {
                            calDataBase[0].isLogInApproved = false
                        }), secondaryButton: .cancel())
                    }
                    Button{
                        self.showsAlert = true
                    } label: {
                        Text("Clear Data").foregroundStyle(Color.red)
                    }.alert(isPresented: $showsAlert) {
                        
                        if (calDataBase.count > 0){
                            Alert(title: Text("Confirm"),
                                  message: Text("This deletes all your data"),
                                  primaryButton: .destructive(
                                    Text("Delete"),
                                    action: {
                                        deletAllData()
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
                .navigationTitle("Hello \(calDataBase[0].userName)")
                .onChange(of: deviceAppearance) { _ in
                    // Apply appearance changes when the selected style changes
                    deviceAppearance.applyAppearance()
                }
            }
            
        }
        
    }
    func deletAllData(){
        do {
            try dataFromDataBase.delete(model: DietData.self)
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
}

#Preview {
    SettingsView()
}
