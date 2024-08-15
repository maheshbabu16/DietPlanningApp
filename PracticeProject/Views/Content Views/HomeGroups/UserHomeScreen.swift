//
//  UserHomeScreen.swift
//  PracticeProject
//
//  Created by Mahesh babu on 05/04/24.
//

import SwiftUI
import SwiftData

struct UserHomeScreen: View {
    
    //MARK: - Property Wrappers
    @Namespace var profileAnimation
    @Environment(\.modelContext) var formData
    
    @State private var foodDataStorage: [CalorieModel]      = []
    @State private var arrHomeItems   : [ActivityCardModel] = [
        ActivityCardModel(title: "New", bgColor: Color.brownBlackGradient),
        ActivityCardModel(title: "Favourites", bgColor: Color.titleGradientColor),
        ActivityCardModel(title: "Trending", bgColor: Color.orangeYellowGradient),
        ActivityCardModel(title: "Suggestions", bgColor: Color.btnGradientColor2)
    ]
    @State private var arrSideItems : [ActivityCardModel] = [
        ActivityCardModel(title: "Track",subTitle: "Have a track of your calories", bgColor: Color.brownBlackGradient),
        ActivityCardModel(title: "BMI",subTitle: "Calculate your BMI and get personal suggestions for your diet and workout", bgColor: Color.redYellowGradient),
        ActivityCardModel(title: "Shedule",subTitle: "Shedule your workout chart", bgColor: Color.btnGradientColor2),
        ActivityCardModel(title: "Tips",subTitle: "Want to know more..?", bgColor: Color.cardGradient)
    ]
    @State private var totalCaloriesStr : String = "0"
    @State private var drawingStroke = false
    @State private var onlineImageExpanded = false
    @State private var showDarkModeScreen = false
    @State var selectedOnlineImage: UIImage?
    @StateObject var apiManager = APIManager()

    //MARK: - Outside variables
    @Binding var tabItemTag : Int
    
    var totalCalories: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.calCount) ) }
    }
    
    var cardHeight : CGFloat = 200
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    //MARK: - Content View
    var body: some View {
        ScrollView(.vertical) {
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
                            .onAppear { drawingStroke = true }
                    }.padding()
                }.frame(height: cardHeight-15)
                    .padding(.horizontal)
                
            }header: {
                NavigationLink {
                    UserStatisticsView()
                } label: {
                    HStack{
                        Text("Your Activity")
                            .bold()
                            .font(.title2)
                            .foregroundStyle(Color.textColor)
                        Image(systemName: "chevron.right").bold()
                        Spacer()
                    }.padding([.horizontal, .top])
                }.tint(Color.textColor)
            }
            
            Section{
                ScrollView(.horizontal){
                    LazyHGrid(rows: [GridItem()], alignment: .center, spacing: 10, content: {
                        ForEach(arrSideItems) { home in
                            if let title = home.title, let subTitle = home.subTitle, let gradient = home.bgColor {
                                
                                ZStack(alignment: .topLeading){
                                    ZStack(alignment: .bottom){
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(gradient)
                                        ZStack(alignment: .center){
                                            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 0)
                                                .fill(Color.black.opacity(0.5))
                                            Text("\(subTitle)")
                                                .font(.footnote)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(3)
                                                .foregroundStyle(Color.white)
                                                .padding(5)
                                        }
                                        .frame(height: 75)
                                    }
                                    .frame(width: 250, height: 275)
                                    .onTapGesture {
                                        if title == "Track"{
                                            tabItemTag = 1
                                        }else if title == "Shedule"{
                                            tabItemTag = 2
                                        }else if title == "BMI"{
                                            
                                        }else if title == "Tips"{
                                            
                                        }
                                    }
                                    Text("\(title)")
                                        .bold()
                                        .font(.title)
                                        .foregroundStyle(Color.white)
                                        .padding([.top, .leading], 20)
                                }
                            }
                        }
                    }).padding(.horizontal)
                } .scrollIndicators(.hidden)
            } header: {
                HStack{
                    Text("For you")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                    Spacer()
                }.padding([.horizontal, .top])
                
            }
            Section{
                LazyVGrid(columns: [GridItem()], alignment: .center, spacing: 30, content: {
                    ForEach(arrHomeItems) { home in
                        if let title = home.title, let gradient = home.bgColor{
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("\(title)")
                                    .bold()
                                    .font(.title)
                                    .foregroundStyle(Color.textColor)
                                    .padding(.bottom, 5)
                                ZStack(alignment: .bottom){
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(gradient)
                                    ZStack(alignment: .center){
                                        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0)
                                            .fill(Color.black.opacity(0.5))
                                        Text("This is for purely text purpose which need to be edited later")
                                            .font(.footnote)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(3)
                                            .foregroundStyle(Color.white)
                                            .padding(5)
                                    }
                                    .frame(height: 75)
                                }
                            }.frame(height: 450)
                                .padding(.horizontal)
                                .onTapGesture {
                                    if title == "New"{
                                        
                                    }else if title == "Favourites"{
                                        
                                    }else if title == "Trending"{
                                        
                                    }else if title == "Suggestions"{
                                        
                                    }
                                }
                        }
                    }
                })
            } header: {
                HStack{
                    Text("For you")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                    Spacer()
                }.padding([.horizontal, .top])
            }
        }.onAppear(perform: {
            fetchCalData()
            totalCaloriesStr = foodDataStorage.count > 0 ? String(totalCalories) : "0"
            if let user = UserDefaults.standard.object(forKey: "UserLogIN")as? Int, user == 0{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    showDarkModeScreen.toggle()
                }
            }
        })
        
        .sheet(isPresented: $showDarkModeScreen) {
            UserDefaults.standard.setValue(1, forKey: "UserLogIN")
        } content: {
            ThemePrefrenceIntroView {
                showDarkModeScreen.toggle()
            }.interactiveDismissDisabled()
        }
    }
}

//MARK: - Extension for functions
extension UserHomeScreen{
    
    func fetchCalData(){
        let userID =  UserDefaults.standard.value(forKey: "UserID") as! String
        let descriptor = FetchDescriptor<CalorieModel>(predicate: #Predicate { data in
            data.userID == userID
        })
        do {
            foodDataStorage = try formData.fetch(descriptor)
            print(foodDataStorage)
        }catch {
            
        }
    }
}

//MARK: - Preview
#Preview {
    UserHomeScreen(tabItemTag: .constant(0))
}

struct ActivityCardModel: Identifiable {
    var id = UUID()
    var title : String?
    var subTitle : String?
    var bgColor : LinearGradient?
    var bgImage : String?
}
