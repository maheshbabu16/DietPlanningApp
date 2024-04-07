//
//  BMISuggestionView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 31/03/24.
//

import SwiftUI

struct BMISuggestionView: View {
    
    @State private var calculateBMI : Bool = false
    
    var skipButtonBlockHandler : (() -> Void)?

    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                VStack(spacing: 25){
                    Spacer()
                    Text("Add your BMI to get suggessions for diet and workout plans.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.02)
                        .lineLimit(2)
                        .padding(.horizontal, 20)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.textColor.opacity(0.15))
                            .frame(height: 200)
                            .padding(.horizontal, 20)
                        Image(systemName: "waveform.path")
                            .resizable()
                            .frame(width: 100, height: 75)
                            .foregroundStyle(LinearGradient(colors: [.red, .black], startPoint: .leading, endPoint: .trailing))
                    }
                    Spacer()
                    Spacer()
                }
                
                VStack(spacing: 20){
                    
                    Button{
                        calculateBMI.toggle()
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                            Text("Calculate")
                                .bold()
                                .foregroundStyle(Color.white)
                        }.frame(width: 300, height: 50)
                    }
                    
                    NavigationLink{
                        GetStartedView {
                            skipButtonBlockHandler?()
                        }
                    }label: {
                        Text("Not now")
                            .bold()
                    }
                }.padding(.bottom, 20)
            }
            .sheet(isPresented: $calculateBMI, onDismiss: {
                
            }, content: {
                EmptyView()
                    .presentationDragIndicator(.visible)
            }).presentationDetents([.fraction(0.75)])
                
        }
    }
}

#Preview {
    BMISuggestionView()
}
