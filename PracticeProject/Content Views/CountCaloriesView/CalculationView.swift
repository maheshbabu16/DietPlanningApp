//
//  CalculationView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 14/11/23.
//
import SwiftData
import SwiftUI

struct CalculationView: View {
    
    //MARK: - Property Wrappers for variables
    @State private var foodDataStorage: [CalorieModel] = []
    
    @Environment(\.modelContext) var formData
    @State private var isSheetPresented = false
    
    
    var totalCalories: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.calCount) ) }
    }
    var totalProtien: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.protienCount) ) }
    }
    var totalCarbs: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.carbsCount) ) }
    }
    var totalFats: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.fatsCount) ) }
    }
    

    var body: some View {
        NavigationView{
            
            ZStack{
                if !(totalCalories > 0) {
                    VStack{
                        Text("Add your data")
                            .font(.system(size: 20))
                        Button{
                            isSheetPresented.toggle()
                        }label: {
                            Image(systemName: "note.text.badge.plus")
                        }
                        .foregroundStyle(Color.btnGradientColor)
                        .frame(height: 100)
                        .padding(.top)
                    }
                    
                } else {
                    List{
                        Section{
                                TitleHeaderView()
                                VStack(spacing: 5){
                                    ForEach(foodDataStorage) { item in
                                        CalculateRowCell(foodItem: item)
                                            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                                                
                                                Button{

                                                }label: {
                                                    Image(systemName: "trash")
                                                }.tint(Color.red)
                                            })
                                            .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                                                
                                                Button{

                                                }label: {
                                                    Image(systemName: "pencil")
                                                }.tint(Color.blue)
                                            })

                                    }
                                }
                        } .listRowBackground(Color.clear)
                            .listRowSeparatorTint(Color.clear)
                        
                        
                        Section(){
                            VStack{

                                HStack{
                                    Text("Total Protien")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                    Spacer()
                                    Text("\(totalProtien) g")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                }
                                .padding([.top, .leading, .trailing], 10.0)

                                HStack{
                                    Text("Total Carbs")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                    Spacer()
                                    Text("\(totalCarbs) g")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                }
                                .padding([.top, .leading, .trailing], 10.0)

                                HStack{
                                    Text("Total Fats")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                    Spacer()
                                    Text("\(totalFats) g")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                }
                                .padding([.top, .leading, .trailing], 10.0)
                                HStack{
                                    Text("Total calories")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                    Spacer()
                                    Text("\(totalCalories) Kcal")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .minimumScaleFactor(0.2)
                                }
                                .padding([.top, .leading, .trailing], 10.0)
                                .listRowBackground(Color.clear)
                            }
                        }
                           
                        .listRowSeparatorTint(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                        .background(Color.clear)
                    
                }
            }
            .onAppear(perform: {
                fetchData()
            })
            .toolbar {
                if (totalCalories > 0) {
                    Button{
                        isSheetPresented.toggle()
                    }label: {
                        Image(systemName: "note.text.badge.plus").foregroundStyle(Color.btnGradientColor)
                    }
                }
            }.sheet(isPresented: $isSheetPresented) {
                CalculateDetailScreen(
                    calCountDatabase: $foodDataStorage, dismissSheetHandler: {
                        isSheetPresented.toggle()
                        fetchData()
                    }
                )
                .presentationDetents([.medium, .large])
            }
            .navigationTitle("Calories")
        }
    }
    
    func fetchData(){
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
    func deleteItemAtRow(_ indexSet: IndexSet){
        for index in indexSet {
               let destination = foodDataStorage[index]
            formData.delete(destination)
            }
    }
}

#Preview {
    CalculationView()
}
