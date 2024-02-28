//
//  CheckMarkViewScreen.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI

struct CheckMarkViewScreen : View {
    var automaticDismissHandler: (() -> Void)?
    
    var body : some View{
        ZStack{
            VStack{
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.textColor.opacity(0.15))
                    .padding(50)
                Text("Success")
                    .bold()
                    .foregroundStyle(Color.textColor.opacity(0.35))
            }.padding()
        }.background(.thinMaterial)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    self.automaticDismissHandler?()
                }
            })
    }
}

#Preview {
    CheckMarkViewScreen()
        .cornerRadius(20).frame(height: 300)
        .preferredColorScheme(.light)
}
