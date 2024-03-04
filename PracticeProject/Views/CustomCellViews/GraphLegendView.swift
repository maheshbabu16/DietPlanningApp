//
//  GraphLegendView.swift
//  PracticeProject
//
//  Created by Mahesh on 04/03/24.
//

import SwiftUI

struct GraphLegendView : View{
    var legendColor : Color
    var legendName : String
    
    var body: some View{
        HStack{
            Circle()
                .fill(legendColor)
                .frame(height: 10)
            Text("\(legendName)")
                .font(.system(size: 14))
                .bold()
                .minimumScaleFactor(0.002)
        }
    }
}
