//
//  CalculateRowCell.swift
//  PracticeProject
//
//  Created by Mahesh on 15/02/24.
//

import SwiftUI

struct CalculateRowCell: View {
    
    let foodItem: CalorieModel
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

