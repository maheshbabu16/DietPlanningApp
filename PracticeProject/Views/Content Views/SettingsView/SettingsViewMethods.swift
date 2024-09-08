//
//  SettingsViewMethods.swift
//  PracticeProject
//
//  Created by Mahesh babu on 08/09/24.
//

import Foundation
import SwiftUI

class SettingsViewMethods : ObservableObject {
    
    func changePasswordView () -> some View {
        HStack {
            Image(systemName: "key.radiowaves.forward").foregroundStyle(Color.blue)
            Text("Change Password")
                .font(.system(size: 14))
        }
    }
    
    func faceIDView (isFaceIDEnabled : Bool) -> some View {
        HStack{
            HStack{
                Image(systemName: "faceid")
                Text("Unlock with FaceID").font(.system(size: 14))
            }
            Spacer()
            Image(systemName: isFaceIDEnabled ? "checkmark.seal" : "circle.fill")
                .foregroundStyle(isFaceIDEnabled ? Color.green : Color.red)
        }.foregroundStyle(Color.primary)
    }
    
    func changeAppIconView () -> some View {
        HStack{
            HStack{
                Image(systemName: "square.dashed").font(.system(size: 14))
                Text("Select Icon").font(.system(size: 14))
            }
            Spacer()
            
            Image(systemName: "ellipsis")
                .font(.system(size: 20))
                .foregroundStyle(Color.red)
        }
    }
    
    func logoutView () -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.textColor.opacity(0.15))
            HStack{
                Image(systemName: "shareplay.slash")
                Text("Logout")
                    .bold()
                    .font(.system(size: 16))
            }.foregroundStyle(Color.red)
        }.frame(height: 50)
    }
    
    func appVersionView() -> some View {
        HStack{
            HStack{
                Image(systemName: "waveform")
                Text("Version").font(.system(size: 14))
            }
            Spacer()
            Text("1.0.0").font(.system(size: 14))
        }
    }
    
    func deleteAccountView() -> some View {
        HStack{
            Image(systemName: "shared.with.you.slash").foregroundStyle(Color.red)
            Text("Delete my account")
                .font(.system(size: 14))
                .foregroundStyle(Color.primary)
        }
    }
    
    func tipsView() -> some View {
        HStack{
            Image(systemName: "rays").foregroundStyle(Color.orange)
            Text("Tips")
        }
    }
}
