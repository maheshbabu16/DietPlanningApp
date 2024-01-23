//
//  CalculationView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 14/11/23.
//
import SwiftData
import SwiftUI

struct CalculationView: View {
    
    @Query var foodDataStorage: [DietData]
    @Environment(\.modelContext) var formData
    
    @State private var isSheetPresented = false
    @State var foodItems: [FoodCount] = []
    
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
                    }
                    
                }else {
                    
                    List{
                        Section{
                            
                                MenuSubView()
                                VStack(spacing: 5){
                                    ForEach(foodDataStorage) { item in
                                        CalculateRowCell(foodItem: item)
                                    }
                                    .onDelete(perform: { indexSet in
                                        deleteItemAtRow(indexSet)
                                    })
                                   
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
            .toolbar{
                Button{
                    isSheetPresented.toggle()
                }label: {
                    Image(systemName: "note.text.badge.plus").foregroundStyle(Color.btnGradientColor)
                }
                
            }.sheet(isPresented: $isSheetPresented) {
                CalculateDetailScreen(
                     dismissSheetHandler: { isSheetPresented.toggle() }
                )
                .presentationDetents([.medium, .large])
            }
            .navigationTitle("Calories")
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


//MARK: - Cell Views
struct CalculateRowCell: View {
    
    let foodItem: DietData
    var body: some View {
        if (((foodItem.calCount != 0) && foodItem.fatsCount != 0) && (foodItem.protienCount != 0) && (foodItem.protienCount != 0)) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.textColor.opacity(0.1))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack{
                    Text(foodItem.name).foregroundStyle(Color.textColor)
                    Spacer()
                    HStack(alignment: .center, spacing: 10){
                        
                        Text("\(foodItem.protienCount)").foregroundStyle(Color.textColor)
                        Text("\(foodItem.carbsCount)").foregroundStyle(Color.textColor)
                        Text("\(foodItem.fatsCount)").foregroundStyle(Color.textColor)
                        Text("\(foodItem.calCount)").foregroundStyle(Color.textColor)
                    }
                    
                }.padding()
            }
        }
    }
}

struct MenuSubView: View {
    var body: some View {
        HStack{
            Text("Food Name")
                .fontWeight(.semibold)
                .foregroundStyle(Color.textColor.opacity(0.5))
                .font(.system(size: 14))
            Spacer()
            HStack(alignment: .center, spacing: 10){
                Text("Pro") .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor.opacity(0.5))
                    .font(.system(size: 14))
                Text("Crab") .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor.opacity(0.5))
                    .font(.system(size: 14))
                Text("Fat") .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor.opacity(0.5))
                    .font(.system(size: 14))
                Text("Kcal")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.textColor.opacity(0.5))
                    .font(.system(size: 14))
            }
            
        }.padding()
    }
}
