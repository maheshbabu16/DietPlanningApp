//
//  AppetiteHomeView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//
import SwiftData
import SwiftUI

struct AppetiteHomeView: View {
    
    @Query(filter: #Predicate<UserDataModel> { data in
            data.isLoginApproved == true
        }) var calCountDatabase: [UserDataModel] 
    
    @Query var calorieData: [CalorieModel]

    @State private var isSheetPresented = false
    @State private var foods:[Food] = Food.preview()
    
    @State private var unhealthyFoods = [
        Food(name: "Pizza", icon: "🍕",  description: "276",isFavorite: false),
        Food(name: "Burger", icon: "🍔", description: "232",isFavorite: false)
    ]
    
   @State var newName: String = ""
   @State var newIcon: String = ""
   @State var newCalorie: String = ""
    
    var body: some View {
        NavigationView{
                
            List {
                if calCountDatabase.count > 0{
                    if let calData = calCountDatabase[0].dietChart {
                        if (calData.calCount > 0) {
                            
                            Section{
                                ScrollView(.horizontal, showsIndicators: false){
                                    LazyHGrid(rows: [GridItem()], spacing: 15) {
                                        
                                        ForEach(calorieData) { diet in
                                            let strCal:String = "\(diet.calCount)"
                                            FoodGridView(
                                                sheetTitle: diet.name,
                                                calorieCount: strCal,
                                                gridWidth: 155,gridHeight: 125,
                                                deleteBlockHandler: {
                                                    //                                                deleteRow(at: IndexSet(integer: index))
                                                }
                                            )
                                        }
                                    }
                                }.frame(height: 130)
                                    .listRowBackground(Color.clear)
                            }header: {
                                Text("Profile")
                            }
                        }
                    }
                }
                
                Section("Healthy Food"){
                    ForEach(foods) { food in
                        FoodRow(food: food)
                    }.onDelete(perform: { indexSet in
                        deleteRow(at: indexSet)
                    })
                }
                
                Section("Unhealthy Food"){
                    ForEach(unhealthyFoods) { food in
                        FoodRow(food: food)
                    }.onDelete(perform: { indexSet in
                        deleteRow(at: indexSet)
                    })
                }
                
            }.listStyle(DefaultListStyle())
                    .background(Color.clear)
            
            .navigationTitle("Food")
            .toolbar{
                Button{
                    isSheetPresented.toggle()
                }label: {
                    Image(systemName: "plus.circle").foregroundStyle(Color.btnGradientColor)
                }

            }.sheet(isPresented: $isSheetPresented) {
                AddAppetiteItemView(foods: $foods,
                               dismissSheetHandler: { isSheetPresented.toggle() } )
                .presentationDetents([.fraction(0.8), .large])
            }
        }
    }
    func addRow(){
        let newFoodItem = Food(name: newName, icon: newIcon, description: newCalorie, isFavorite: false)
        withAnimation{
            foods.append(newFoodItem)
        }
    }
    func deleteRow(at offsets: IndexSet){
        CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
        foods.remove(atOffsets: offsets)
        
    }
}

#Preview {
    AppetiteHomeView()
}
struct FoodRow: View {
    
    let food: Food
    var body: some View {
        
        NavigationLink(destination: AppetiteDetailView(strTitle: food.name, strLogo: food.icon, strDescription: food.description)) {
            HStack(spacing: 20){
                ZStack{
                    Color.blue.opacity(0.25)
                    Text(food.icon)
                }.frame(width: 40, height: 40)
                    .cornerRadius(20)
                
                Text(food.name).font(.system(size: 18)).fontWeight(.regular)
                    .foregroundStyle(Color("TextColor"))
                Spacer()
                
                if (food.isFavorite){
                    Image(systemName: "heart.circle.fill").foregroundStyle(Color.blue)
                }else{
                    Image(systemName: "heart.circle").foregroundStyle(Color.gray)
                }
            }
        }
    }
}
