//
//  HomeListView.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI

struct HomeListView: View {
    
    @State private var arrHomeItems : [ActivityCardModel] = []
//    ["Track Caloires", "Shedule", "Trending", "Favourites"]
    @StateObject var apiManager = APIManager()
    @Namespace var nameSpace
    @Binding var tabItemTag : Int
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack{
            List{
                Section{
                    ScrollView(.horizontal){
                        LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 20, content: {
                            ForEach(arrHomeItems) { home in
                                if let title = home.title {
                                    if let gradient = home.bgColor{
                                        ZStack(alignment: .bottomLeading){
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(gradient)
                                                Color.black.opacity(0.15)
                                            }
                                            Text("\(title)")
                                                .bold()
                                                .font(.title)
                                                .foregroundStyle(Color.white)
                                                .padding()
                                        }.frame(width: 230, height: 285)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        })
                    }
                    .listRowSeparator(.hidden)
                }header: {
                    Text("Activity")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                }

                
                Section{
                    ScrollView(.horizontal){
                        LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 20, content: {
                            withAnimation {
                                ForEach(apiManager.imageArray) { images in
                                    if let newImage = images.image{
                                        NavigationLink {
                                            ImageExpandedView(imgSelected: newImage)
                                        } label: {
                                            ZStack(alignment: .bottomLeading){
                                                ZStack{
                                                    Image(uiImage: newImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(10)
                                                    Color.black.opacity(0.15)
                                                }
                                                
                                                Text("New")
                                                    .bold()
                                                    .font(.title)
                                                    .foregroundStyle(Color.white)
                                                    .padding()
                                            }
                                        }.frame(height: 185)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        })
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text("Top picks for you")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                }
                
                Section{
                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blueYellowGradient)
                        
                        Text("New")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: 200)
                        .listRowSeparator(.hidden)

                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.titleGradientColor)
                        
                        Text("Trending")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: 200)
                        .listRowSeparator(.hidden)
                
                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.btnGradientColor)
                        
                        Text("For You")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: 200)
                        .listRowSeparator(.hidden)
             
                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.viewGradientColor)
                        
                        Text("Your Favourites")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: 200)
                        .listRowSeparator(.hidden)
                } header: {
                    Text("More...")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                }
            }.listStyle(PlainListStyle())
                .task {
                    for _ in 1...20 {
                        await apiManager.loadImagesFromAPIUrl()
                    }
                }
                .onAppear(perform: {
                    addHomeData()
                })
                .frame(maxWidth: .infinity)
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus")
                            .foregroundStyle(Color.btnGradientColor)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "externaldrive.fill.trianglebadge.exclamationmark")
                            .foregroundStyle(Color.yellow)
                    }
                }
        }
    }
    func addHomeData(){
        arrHomeItems = [
            ActivityCardModel(title: "Trending", bgColor: Color.viewGradientColor),
            ActivityCardModel(title: "Track", bgColor: Color.pinkNeonGradient),
            ActivityCardModel(title: "Shedule", bgColor: Color.blueYellowGradient),
            ActivityCardModel(title: "Favourites", bgColor: Color.titleGradientColor),
            ActivityCardModel(title: "Mood", bgColor: Color.btnGradientColor)
        ]
    }
}

struct ActivityCardModel: Identifiable {
    
    var id = UUID()
    var title : String?
    var subTitle : String?
    var bgColor : LinearGradient?
    var bgImage : String?
}
#Preview {
    HomeListView(tabItemTag: .constant(0))
        .preferredColorScheme(.dark)
}
