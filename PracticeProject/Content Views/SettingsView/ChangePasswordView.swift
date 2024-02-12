//
//  ChangePasswordView.swift
//  PracticeProject
//
//  Created by Mahesh on 12/02/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Binding var textFeildStr: String
    @State var sheetTitle : String = ""
    @State var iconImg : String = ""

    var placeHolder: String = ""
    var strUsername: String = ""
    var editButtonClicked: (() -> Void)?
    var sheetType : SheetType
    
   public enum SheetType {
        case changePassword
        case editUserName
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                    if sheetType == .editUserName{
                        LoginTextFeildView(textFeildStr: $textFeildStr, placeHolder: "Enter new username here").frame(height: 60).padding()
                    } else if sheetType == .changePassword{
                        VStack(spacing: 40){
                            LoginTextFeildView(textFeildStr: $textFeildStr, placeHolder: "Enter Old password").frame(height: 60)
                            VStack{
                                LoginTextFeildView(textFeildStr: $textFeildStr, placeHolder: "Enter New Password").frame(height: 60)
                                LoginTextFeildView(textFeildStr: $textFeildStr, placeHolder: "Confirm Password").frame(height: 60)
                            }
                        }.padding(10)
                }
            }.toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(sheetTitle)")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color.white)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        self.editButtonClicked?()
                    }label: {
                        Image(systemName: "\(iconImg)").foregroundStyle(Color.btnGradientColor)
                    }
                }
            })
        }
        .onAppear(perform: {
            if sheetType == .editUserName{
                sheetTitle = "Edit Username"
                iconImg = "person.crop.circle.badge.checkmark"
            } else if sheetType == .changePassword{
                sheetTitle = "Change Password"
                iconImg = "rectangle.and.pencil.and.ellipsis"
            }
        })
    }
}

#Preview {
    ChangePasswordView(textFeildStr: .constant(""), placeHolder: "Edit", sheetType: .changePassword)
}
