//
//  HomeDetailView.swift
//  PracticeProject
//
//  Created by Mahesh on 19/02/24.
//

import SwiftUI

struct HomeDetailView: View {
    @State private var foods:[Food] = Food.preview()
    var closeButtonHandler : (() -> Void)?
    var backgroundGredient : LinearGradient
    var imageString : String
    var imageHeight : CGFloat
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    self.backgroundGredient
                    ZStack(alignment: .topTrailing){
                        Image("\(imageString)")
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                        Button{
                            self.closeButtonHandler?()
                        }label: {
                            ZStack{
                                Color.black.opacity(0.15)
                                Image(systemName: "xmark")
                                    .bold()
                                    .foregroundStyle(Color.black)
                            }.cornerRadius(20)
                                .frame(width:40, height:40)
                                .padding(.top, 50)
                                .padding(.trailing, 10)
                        }
                    }
                }.frame(height: imageHeight)
                
                LazyVGrid(columns: [GridItem()], content: {
                    ForEach(foods) { food in
                        NavigationLink {
                            
                        } label: {
                            FoodRow(food: food).padding()
                        }
                    }
                })
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    HomeDetailView(backgroundGredient: Color.btnGradientColor, imageString: "IconApp", imageHeight: 400)
}
