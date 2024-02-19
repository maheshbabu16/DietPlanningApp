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
        ZStack(alignment: .topTrailing){
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(customBackgroundColor)
                    
                    VStack{
                            Image("\(backgroundImageString)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*3/5)
                        
                        VStack(alignment: .leading, spacing: 10){
//                            Text("\(strCardTitle)")
//                                .bold()
//                                .multilineTextAlignment(.leading)
//                                .foregroundStyle(Color.white)
//                                .fontWeight(.medium)
//                                .lineLimit(1)
//                                .font(.title)
                            Text("\(strCardDescription)")
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.white)
                                .lineLimit(2)
                                .font(.headline)
                                .bold()
                        }.padding(.bottom, 0)
                        .padding(.horizontal)
                    }.frame(height: height)
                }.frame(height: height)
            Button{
                
            }label: {
                ZStack{
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 0, topTrailingRadius: 15)
                        .fill(Color.red)
                    Text("\(strCardTitle)")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color.white)
                        
                }.frame(minWidth: height*1/3, maxWidth: height/2)
                .frame(height: 40)
            }
        }.padding()
    }
}

#Preview {
    FoodCardView(height: 400, strCardTitle: "Hello", strCardHeadLine: "This is a sub line for card", strCardDescription: "Your can view the list of all food items with unhealthy foods", backgroundImageString: "google.logo", customBackgroundColor: Color.btnGradientColor)
}