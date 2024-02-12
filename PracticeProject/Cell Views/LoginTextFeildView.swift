//
//  LoginTextFeildView.swift
//  PracticeProject
//
//  Created by Mahesh on 12/02/24.
//

import SwiftUI

struct LoginTextFeildView: View {
    
    @Binding var textFeildStr: String
    
    var placeHolder: String
    var strUsername: String?
    var showEditButton: Bool = false
    var editButtonClicked: (() -> Void)?
    
    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.15))
                
                TextField("", text: $textFeildStr,
                          prompt: Text("\(placeHolder)")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 15))
                )
                .padding()
                .foregroundStyle(Color.white)
            }
        }
}
#Preview {
    LoginTextFeildView(textFeildStr: .constant("Mahesh"), placeHolder: "Enter text")
}
