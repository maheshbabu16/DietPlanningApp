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
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVGrid(columns: [GridItem()], content: {
                        ForEach(cards) { card in
                            FoodCardView(height: 450,
                                         strCardTitle: card.cardTitle,
                                         strCardHeadLine: card.cardHeadTitle, strCardDescription: card.cardDesc, expandButtonHandler: {
                                self.isSheetExpanded.toggle()
                               
                            }, backgroundImageString: card.backgroundImageString, customBackgroundColor: card.backgroundGradient).fullScreenCover(isPresented: $isSheetExpanded,onDismiss: {
                                addData()
                            }, content: {
                                HomeDetailView(closeButtonHandler: {
                                    self.isSheetExpanded.toggle()
                                }, backgroundGredient: card.backgroundGradient, imageString: card.backgroundImageString, imageHeight: 400)
                            })
                        }
                    })
                })
            }.padding(.horizontal, 5)
                .navigationTitle("Home")
        }
        .onAppear(perform: {
            addData()
        })
    }
    
    func addData(){
        cards = [
            FoodCardRow(cardTitle: "High in protien", cardHeadTitle: "", cardDesc: "", backgroundGradient: Color.viewGradientColor, backgroundImageString: "rainbow"),
            FoodCardRow(cardTitle: "Healthy Foods", cardHeadTitle: "", cardDesc: "", backgroundGradient: Color.btnGradientColor, backgroundImageString: "IconApp"),
            FoodCardRow(cardTitle: "Unhealthy Food", cardHeadTitle: "", cardDesc: "", backgroundGradient: Color.viewGradientColor, backgroundImageString: "IconApp"),
            FoodCardRow(cardTitle: "High in fats", cardHeadTitle: "", cardDesc: "", backgroundGradient: Color.btnGradientColor, backgroundImageString: "google.logo")
        ]
    }
}

#Preview {
    HomeMainView()
}
