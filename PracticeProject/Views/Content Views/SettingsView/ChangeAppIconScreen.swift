//
//  ChangeAppIconScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 08/09/24.
//

import SwiftUI

struct ChangeAppIconScreen: View{
    
    @State var appIconList : [APPIconModel] = APPIconModel.preview()
    @AppStorage("active_icon") var activeAppIcon : String = "AppIcon"
    @Binding var tooggleSheet: Bool

    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom) {
                List{
                    ForEach(appIconList) { appIcon in
                        Button{
                            activeAppIcon = appIcon.iconTag
                        }label: {
                            HStack {
                                HStack {
                                    Image("\(appIcon.thumbImage)")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text("\(appIcon.name)")
                                        .bold()
                                        .foregroundStyle(Color.textColor)
                                }
                                Spacer()
                                Image(systemName: activeAppIcon == appIcon.iconTag ? "checkmark.seal.fill" : "")
                                    .foregroundStyle(Color.brownBlackGradient)
                                    .padding(.vertical)
                            }
                        }
                        .listRowBackground((Color.textColor.opacity(0.15)))
                    }
                }
                .onChange(of: activeAppIcon) { oldValue, newValue in
                    UserDefaults.standard.setValue(newValue, forKey: "active_icon")
                    UIApplication.shared.setAlternateIconName(newValue)
                }
            }
            .navigationTitle("Choose Icon")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        tooggleSheet.toggle()
                    }, label: {
                        Text("Dismiss")
                            .bold()
                    })
                }
            })
        }
    }
}

#Preview {
    ChangeAppIconScreen(tooggleSheet: .constant(false))
}

struct APPIconModel: Identifiable {
    
    var id = UUID()
    var name : String
    var thumbImage : String
    var iconTag : String
    
    static func preview() -> [APPIconModel]{
        [
            APPIconModel(name: "Default", thumbImage: "IconApp", iconTag: "AppIconMain"),
            APPIconModel(name: "P Icon", thumbImage: "pIcon", iconTag: "AppIcon2"),
            APPIconModel(name: "Rainbow Icon", thumbImage: "rainbow", iconTag: "AppIcon3")
        ]
    }
}
