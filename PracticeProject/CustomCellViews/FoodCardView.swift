//
//  FoodCardView.swift
//  PracticeProject
//
//  Created by Mahesh on 19/02/24.
//

import SwiftUI

struct FoodCardView: View {
    var height : CGFloat
    var strCardTitle : String
    var strCardHeadLine : String
    var strCardDescription : String
    var expandButtonHandler : (() -> Void)?
    var backgroundImageString : String
    var customBackgroundColor : LinearGradient
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                ZStack{
                    UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15)
                        .fill(customBackgroundColor)

                    ZStack(alignment: .bottom){

                            Image("\(backgroundImageString)")
                                .resizable()
                                .scaledToFit()
                                .mask {
                                    UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15)
                                }
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("\(strCardHeadLine)")
                                .foregroundStyle(Color.white)
                                .fontWeight(.medium)
                                .lineLimit(1)
                                .font(.system(size: 18))
                            
                            Text("\(strCardDescription)")
                                .foregroundStyle(Color.white)
                                .lineLimit(2)
                                .font(.system(size: 25))
                                .bold()
                        }
                        .padding(.bottom, 20)

                    }.frame(height: height*4/5)
                }.frame(height: height*4/5)
                
                ZStack(alignment: .leading){
                    
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0)
                        .fill(Color.textColor.opacity(0.15))
                    
                    HStack{
                        Text("\(strCardTitle)")
                            .font(.system(size: 20))
                            .bold()
                        Spacer()
                        
                        Button {
                            self.expandButtonHandler?()
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.textColor.opacity(0.15))
                                Text("Expand")
                                    .minimumScaleFactor(0.2)
                                    .foregroundStyle(Color.primary)
                                    .bold()
                            }
                        }.frame(width: 100, height: height/12)
                    }.padding()
                }.frame(height: height/5)
            }.frame(height: height)
        }
            .padding()
    }
}

#Preview {
    FoodCardView(height: 400, strCardTitle: "Hello", strCardHeadLine: "This is a sub line for card", strCardDescription: "This is a description for card that can be customised later", backgroundImageString: "google.logo", customBackgroundColor: Color.btnGradientColor)
}
