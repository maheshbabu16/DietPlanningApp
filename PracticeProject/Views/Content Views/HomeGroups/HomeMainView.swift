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
    @State var showProfileImage : Bool = false
    @Namespace var nameSpace
    
    var body: some View {
        ZStack{
            if showProfileImage{
                ZStack(alignment: .center) {
                    Color.black.opacity(0.15).ignoresSafeArea()
                        Image("flower")
                                   .resizable()
                                   .clipShape(Circle())
                                   .matchedGeometryEffect(id: "image", in: nameSpace)
                                   .frame(width: 300,height: 300)
                }.onTapGesture {
                    withAnimation(.spring) {
                        showProfileImage.toggle()
                    }
                }
            }else {
                NavigationStack{
                    ZStack{
                        ScrollView(.vertical, showsIndicators: false, content: {
                            LazyVGrid(columns: [GridItem()], content: {
                                ForEach(cards) { card in
                                    FoodCardView(height: 400,
                                                 strCardTitle: card.cardTitle,
                                                 strCardHeadLine: card.cardHeadTitle, strCardDescription: card.cardDesc, expandButtonHandler: {
                                        self.isSheetExpanded.toggle()
                                        
                                    }, backgroundImageString: card.backgroundImageString, customBackgroundColor: card.backgroundGradient)
                                    .fullScreenCover(isPresented: $isSheetExpanded,onDismiss: {
                                        addData()
                                    }, content: {
                                        
                                        HomeDetailView(closeButtonHandler: {
                                            self.isSheetExpanded.toggle()
                                        }, backgroundGredient: card.backgroundGradient, imageString: card.backgroundImageString, imageHeight: 350)
                                    }) .transition(.move(edge: .trailing))
                                }
                            })
                        })
                        
                        
                    }.padding(.horizontal, 5)
                        .navigationTitle("Home")
                    
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarTrailing, content: {
                                Button{
                                    withAnimation(.spring) {
                                        showProfileImage.toggle()
                                    }
                                }label: {
                                    Image("flower")
                                        .resizable()
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "image", in: nameSpace)
                                        .scaledToFit()
                                        .frame(width: 75,height: 75)
                                }.padding(.bottom)
                            })
                            
                            ToolbarItem(placement: .topBarLeading, content: {
                                NavigationLink {
                                    ImageGalleryView()
                                } label: {
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .foregroundStyle(Color.btnGradientColor)
                                }
                            })
                        })
                }
            }

        }.onAppear(perform: {
            addData()
        })
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
