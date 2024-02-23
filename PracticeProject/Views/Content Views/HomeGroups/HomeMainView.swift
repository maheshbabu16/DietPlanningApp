//
//  HomeMainView.swift
//  PracticeProject
//
//  Created by Mahesh on 19/02/24.
//

import SwiftUI

struct HomeMainView: View {
    
    @State var isSheetExpanded : Bool = false
    @State private var arrCards : [String] = ["Healthy Foods", "Unhealthy Food", "High in protien", ]
    
    @State private var cards : [FoodCardRow] = []
    @State private var profilePhotoTapped : Bool = false
    @State private var gridTapped : Bool = false
    
    @Namespace private var nameSpace
    @Namespace private var newNameSpace
    
    var body: some View {
        ZStack{
            NavigationStack{
                ZStack{
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVGrid(columns: [GridItem()], spacing: 15, content: {
                            ForEach(cards) { card in
                                NavigationLink {
                                    HomeDetailView(closeButtonHandler: {
                                        self.isSheetExpanded.toggle()
                                    }, backgroundGredient: card.backgroundGradient, imageString: card.backgroundImageString, imageHeight: 350)
                                } label: {
                                    FoodCardView(height: 400,
                                                 strCardTitle: card.cardTitle,
                                                 strCardHeadLine: card.cardHeadTitle, strCardDescription: card.cardDesc, expandButtonHandler: {
                                        self.isSheetExpanded.toggle()
                                        
                                    }, backgroundImageString: card.backgroundImageString, customBackgroundColor: card.backgroundGradient)
                                }
                            }.onTapGesture {
                                self.isSheetExpanded.toggle()
                            }
                        })
                    })
                }.blur(radius: profilePhotoTapped ? 100 : 0)
                    .padding()
                    .navigationTitle("Home")
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Image("flower")
                                .resizable()
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: "image", in: nameSpace)
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .padding(.bottom)
                                .onTapGesture{
                                    withAnimation(.spring) {
                                        CommonFunctions.Functions.getHapticFeedback(impact: .light)
                                        profilePhotoTapped.toggle()
                                    }
                                }
                        }
                    })
            }
            .onAppear(perform: {
                
                addData()
            })
            
            if profilePhotoTapped{
                ZStack {
                    Color.black.opacity(0)
                        .ignoresSafeArea()
                    Image("flower")
                        .resizable()
                        .clipShape(Circle())
                        .matchedGeometryEffect(id: "image", in: nameSpace)
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                }.onTapGesture {
                    withAnimation(.spring) {
                        CommonFunctions.Functions.getHapticFeedback(impact: .light)
                        profilePhotoTapped.toggle()
                    }
                }
            }
        }
    }
    
    func addData(){
        cards = [
            FoodCardRow(cardTitle: "High in protien", cardHeadTitle: "", cardDesc: "Your can view the list of all food items with high protien", backgroundGradient: Color.pinkNeonGradient, backgroundImageString: "rainbow"),
            FoodCardRow(cardTitle: "Healthy Foods", cardHeadTitle: "", cardDesc: "Your can view the list of all food items with Healthy foods", backgroundGradient: Color.pinkYellowGradient, backgroundImageString: "IconApp"),
            FoodCardRow(cardTitle: "Unhealthy Food", cardHeadTitle: "", cardDesc: "Your can view the list of all food items with unhealthy foods", backgroundGradient: Color.viewGradientColor, backgroundImageString: "IconApp"),
            FoodCardRow(cardTitle: "High in fats", cardHeadTitle: "", cardDesc: "Your can view the list of all food items with high fats", backgroundGradient: Color.blueYellowGradient, backgroundImageString: "google.logo")
        ]
    }
}

#Preview {
    HomeMainView()
}
