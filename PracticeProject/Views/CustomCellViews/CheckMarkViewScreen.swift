//
//  CheckMarkViewScreen.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI

struct CheckMarkViewScreen : View {
    var automaticDismissHandler: (() -> Void)?
    @State var animate : Bool = false
    var body : some View{
        ZStack{
            VStack{
                Image(systemName: animate ? "checkmark" : "person.fill")
                    .resizable()
                    .scaledToFit()
                    .symbolEffect(.bounce, value: animate)
                    .foregroundStyle(Color.brownBlackGradient)
                    .padding(50)
                Text("Success")
                    .bold()
                    .foregroundStyle(Color.brownBlackGradient)
            }.padding()
        }.background(.thinMaterial)
            .onAppear(perform: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    animate.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        self.automaticDismissHandler?()
                    }
                }
            })
    }
    
}

#Preview {
    CheckMarkViewScreen()
        .cornerRadius(20).frame(height: 300)
        .preferredColorScheme(.light)
}
