//
//  AddNewItemView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct AddNewItemView: View {
    
    @State private var foodName: String = ""
    @State private var foodIcon: String = ""
    @State private var foodDesc: String = ""
    @State private var isFav: Bool = false
    @Binding var foods: [Food]
    
//    @State private var foods:[Food] = Food.preview()
    
    var dismissSheetHandler: (() -> Void)?

    var body: some View {
        NavigationView{
            List{
                Section("Add Item"){
                    TextField("Name", text: $foodName)
                    TextField("Icon", text: $foodIcon).keyboardType(.default)
                    TextField("Calories", text: $foodDesc).keyboardType(.numberPad)
              }
                Section("Add to favourites"){
                    Toggle("Favourite ?", isOn: $isFav)
                }
            }
            .toolbar{
                Button{
                    if (foodName.count > 0) || (foodIcon.count > 0) || (foodDesc.count > 0){
                        addItem()
                    }
                    dismissSheetHandler?()
                    
                }label: {
                    Text(Constants.Text.doneTitle).foregroundStyle(Color.btnGradientColor)
                }
            }
            .navigationBarTitle(Constants.Text.addTitle, displayMode: .inline)
        }
    }
    func addItem() {
        
        let newFoodItem = Food(name: foodName, icon: foodIcon, description: foodDesc, isFavorite: isFav)
        withAnimation {
            foods.append(newFoodItem)
        }
        foodName = ""
        foodIcon = ""
        foodDesc = ""
    }
}
//
//#Preview {
//    AddNewItemView(foods: $foods)
//}
