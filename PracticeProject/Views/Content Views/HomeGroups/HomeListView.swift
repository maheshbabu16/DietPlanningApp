//
//  HomeListView.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI
import SwiftData
import Charts

struct HomeListView: View {
    
    @Namespace var nameSpace
    @Environment(\.modelContext) var formData
    
    @State private var foodDataStorage: [CalorieModel] = []
    @State private var arrHomeItems : [ActivityCardModel] = []
    @Binding var tabItemTag : Int
    @StateObject var apiManager = APIManager()
    @State var totalCaloriesStr : String = "0"
    @State private var drawingStroke = false
    
    let animation = Animation
        .easeOut(duration: 3)
        .delay(0.5)
    var totalCalories: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.calCount) ) }
    }
    
    var cardHeight : CGFloat = 200
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.textColor.opacity(0.1))
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                VStack(alignment: .leading){
                                    Text("Total Days")
                                        .bold()
                                    
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.textColor)
                                    
                                    Text("6")
                                        .font(.title)
                                        .bold()
                                        .foregroundStyle(Color.textColor)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Total Intake")
                                        .bold()
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color.textColor)
                                    HStack(spacing:2){
                                        Text("\(totalCaloriesStr)")
                                            .font(.title)
                                            .bold()
                                            .foregroundStyle(Color.pink)
                                        Text("Kcal")
                                            .font(.title3)
                                            .foregroundStyle(Color.pink)
                                    }
                                }
                            }.padding(.leading)
                            Spacer()
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(lineWidth: 25)
                                .fill(.pink.opacity(0.35))
                                .padding(20)
                                .overlay {
                                    Circle()
                                        .trim(from: 0, to: drawingStroke ? 6/7 : 0)
                                        .stroke(.pink,
                                                style: StrokeStyle(lineWidth: 25, lineCap: .round))
                                        .padding(20)
                                }
                                .rotationEffect(.degrees(-90))
                                .animation(animation, value: drawingStroke)
                                .onAppear {
                                    drawingStroke = true
                                }
                        }.padding()
                    }.frame(height: cardHeight-15)
                        .listRowSeparator(.hidden)
                    
                }header: {
                    HStack{
                        Text("Your Activity")
                            .bold()
                            .font(.title2)
                            .foregroundStyle(Color.textColor)
                        Spacer()
                        NavigationLink {
                            UserStatisticsView()
                        } label: {
                            Image(systemName: "chevron.right").bold()
                        }.tint(Color.textColor)
                    }
                }
                
                Section{
                    ScrollView(.horizontal){
                        LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 10, content: {
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
                                            .onTapGesture {
                                                if title == "Track"{
                                                    tabItemTag = 1
                                                }else if title == "Shedule"{
                                                    tabItemTag = 2
                                                }
                                                
                                            }
                                    }
                                }
                            }
                        })
                    }.scrollIndicators(.hidden)
                        .listRowSeparator(.hidden)
                }header: {
                    Text("New features")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                }
                
                if apiManager.imageArray.count > 0{
                    withAnimation(.easeIn) {
                        Section{
                            ScrollView(.horizontal){
                                LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 10, content: {
                                    withAnimation {
                                        ForEach(apiManager.imageArray) { images in
                                            if let newImage = images.image{
                                                NavigationLink {
                                                    Image(uiImage: newImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .cornerRadius(10)
                                                        .frame(width: 195*2, height: 195*2, alignment: .center)
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
                            }.scrollIndicators(.hidden)
                                .listRowSeparator(.hidden)
                        } header: {
                            HStack{
                                Text("Top picks")
                                    .bold()
                                    .font(.title2)
                                    .foregroundStyle(Color.textColor)
                                Spacer()
                                NavigationLink {
                                    ImageGalleryView()
                                } label: {
                                    Image(systemName: "chevron.right").bold()
                                }.tint(Color.white)
                            }
                        }
                    }
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
                    }.frame(height: cardHeight)
                        .listRowSeparator(.hidden)
                    
                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.titleGradientColor)
                        
                        Text("Trending")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: cardHeight)
                        .listRowSeparator(.hidden)
                    
                    ZStack(alignment: .bottomLeading){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.viewGradientColor)
                        
                        Text("Favourites")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .padding()
                    }.frame(height: cardHeight)
                        .listRowSeparator(.hidden)
                } header: {
                    Text("For you")
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
                    fetchCalData()
                    totalCaloriesStr = foodDataStorage.count > 0 ? String(totalCalories) : "0"
                })
                .frame(maxWidth: .infinity)
                .navigationTitle("Home")
                .toolbar {
                    
                }
        }
    }
}

extension HomeListView{
    
    func addHomeData(){
        arrHomeItems = [
            ActivityCardModel(title: "Trending", bgColor: Color.viewGradientColor),
            ActivityCardModel(title: "Track", bgColor: Color.pinkNeonGradient),
            ActivityCardModel(title: "Shedule", bgColor: Color.blueYellowGradient),
            ActivityCardModel(title: "Favourites", bgColor: Color.titleGradientColor),
            ActivityCardModel(title: "Mood", bgColor: Color.btnGradientColor)
        ]
    }
    
    func fetchCalData(){
        let userID =  UserDefaults.standard.value(forKey: "UserID") as! String
        let descriptor = FetchDescriptor<CalorieModel>(predicate: #Predicate { data in
            data.userID == userID
        })
        do {
            foodDataStorage = try formData.fetch(descriptor)
            print(foodDataStorage)
        }catch { }
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
