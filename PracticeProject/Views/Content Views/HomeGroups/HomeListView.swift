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
    
    @State private var foodDataStorage: [CalorieModel]      = []
    @State private var arrHomeItems   : [ActivityCardModel] = []
    @State var totalCaloriesStr : String = "0"
    @State private var drawingStroke = false
    @State private var profileImageExpanded = false
    @State private var onlineImageExpanded = false
    @State private var showDarkModeScreen = false
   @State var selectedOnlineImage: UIImage?
    
    @Binding var tabItemTag : Int
    @StateObject var apiManager = APIManager()
    
    var totalCalories: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.calCount) ) }
    }
    
    var cardHeight : CGFloat = 200
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack(alignment: onlineImageExpanded ? .top : .center){
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
                                ActivityProgressView(drawingStroke: $drawingStroke)
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
                    
                    if apiManager.imageArray.count > 0{
                        withAnimation(.easeIn) {
                            Section{
                                ScrollView(.horizontal){
                                    LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 10, content: {
                                        withAnimation {
                                            ForEach(apiManager.imageArray) { images in
                                                if let newImage = images.image{
                                                    ZStack{
                                                        Image(uiImage: newImage)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                                            
                                                        ZStack(alignment: .bottomLeading){
                                                            Color.textColor.opacity(0.15)
                                                            Text("New")
                                                                .bold()
                                                                .font(.system(size: 30))
                                                                .foregroundStyle(Color.mainColor)
                                                                .padding()

                                                        }
                                                    }.frame(width: 185, height: 185)
                                                        .cornerRadius(10)
                                                    
                                                        .onLongPressGesture(perform: {
                                                            CommonFunctions.Functions.getHapticFeedback(impact: .rigid)
                                                                withAnimation(.spring) {
                                                                    onlineImageExpanded.toggle()
                                                                    selectedOnlineImage = newImage
                                                                }
                                                        })
                                                       
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
                                    }.tint(Color.textColor)
                                }
                            }
                        }
                    }
                    
                    Section{
                        ForEach(arrHomeItems) { home in
                            if let title = home.title {
                                if let gradient = home.bgColor{
                                    
                                    ZStack(alignment: .bottomLeading){
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(gradient)
                                        
                                        Text("\(title)")
                                            .bold()
                                            .font(.title)
                                            .foregroundStyle(Color.white)
                                            .padding()
                                    }.frame(height: cardHeight)
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
                        //                    fetchCalData()
                        totalCaloriesStr = foodDataStorage.count > 0 ? String(totalCalories) : "0"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            //                        showDarkModeScreen.toggle()
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .navigationTitle("Home")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                withAnimation(.spring) {
                                    profileImageExpanded.toggle()
                                }
                            } label: {
                                ZStack{
                                    Image("flower")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                    
                                        .matchedGeometryEffect(id: "image", in: nameSpace)
                                }.frame(maxWidth: 50, maxHeight: 50)
                            }
                        }
                    }
                    .sheet(isPresented: $showDarkModeScreen) {
                        
                    } content: {
                        ThemePrefrenceIntroView {
                            showDarkModeScreen.toggle()
                        }
                    }
            }
            if profileImageExpanded{
                ZStack{
                    ZStack{
                        Image("flower")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .matchedGeometryEffect(id: "image", in: nameSpace)
                    }.frame(maxWidth: 200, maxHeight: 200)
                    
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.thinMaterial)
                    .onTapGesture {
                        withAnimation(.spring) {
                            profileImageExpanded.toggle()
                        }
                    }
            }
            if onlineImageExpanded{
                ZStack(alignment: .top){
                    Color.clear
                    VStack{
                        Capsule()
                            .fill(Color.textColor.opacity(0.15))
                            .frame(width: 40, height: 5)
                        VStack(alignment: .leading){
                            Image(uiImage: selectedOnlineImage!)
                                .resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .matchedGeometryEffect(id: "onlineImage", in: nameSpace)
                                .frame(width: 300, height: 300)
                            
                            HStack{
                                Text("New")
                                    .matchedGeometryEffect(id: "AlbumTitle", in: nameSpace)
                                    .bold()
                                    .font(.system(size: 40))
                                    .foregroundStyle(Color.textColor)
                                Spacer()
                            }.padding(.top, 10)
                        }.padding()
                    }
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(.thinMaterial)
                    .onTapGesture {
                        withAnimation(.spring) {
                            onlineImageExpanded.toggle()
                        }
                    }

            }
        }
    }
}

extension HomeListView{
    
    func addHomeData(){
        arrHomeItems = [
            ActivityCardModel(title: "New", bgColor: Color.viewGradientColor),
            ActivityCardModel(title: "Track", bgColor: Color.pinkNeonGradient),
            ActivityCardModel(title: "Shedule", bgColor: Color.blueYellowGradient),
            ActivityCardModel(title: "Favourites", bgColor: Color.titleGradientColor),
            ActivityCardModel(title: "Trending", bgColor: Color.pinkYellowGradient),
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
//        .preferredColorScheme(.dark)
}
