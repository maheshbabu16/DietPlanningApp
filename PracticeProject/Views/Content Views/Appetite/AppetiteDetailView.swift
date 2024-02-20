//
//  AppetiteDetailView.swift
//  ListPractice
//
//  Created by Mahesh babu on 13/11/23.
//

import SwiftUI

struct AppetiteDetailView: View {
    
    var strTitle: String = ""
    var strLogo: String = ""
    var strDescription: String = ""
    
    var body: some View {
            ZStack{
                Color.viewGradientColor.ignoresSafeArea()
                Color.clear
                    .blur(radius: 5)
                    .padding()
                
                    List{
                        Section("Details"){
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.1))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                VStack(alignment: .leading, spacing: 10){
                                    
                                    Text("\(strLogo)").font(.system(size: 75))
                                    Text("\(strTitle)")
                                        .foregroundStyle(LinearGradient(colors: [.pink, .yellow], startPoint: .top, endPoint: .bottomTrailing))
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        
                                }.padding()
                            }
                        }
                        .listRowSeparatorTint(Color.clear, edges: .all)
                        .listRowBackground(Color.clear)
                        
                        Section("Nutrition Value"){
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black.opacity(0.1))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                VStack(alignment: .leading, spacing: 10){
                                    HStack{
                                        Text("\(strDescription)")
                                            .font(.system(size: 100))
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.textGradient)
                                        VStack{
                                            Spacer()
                                            Spacer()
                                            Text("Kcal")
                                                .font(.system(size: 20))
                                                .fontWeight(.medium)
                                                .foregroundStyle(Color.textGradient)
                                            Spacer()
                                        }
                                        
                                    }
                                    Text("100g of \(strTitle) contains \(strDescription) Kcal")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(Color.textColor)
                                }.padding([.leading, .bottom])
                                
                            }
                            
                            
                        }
                        .listRowSeparatorTint(Color.clear, edges: .all)
                        .listRowBackground(Color.clear)
                        

                    }.background(Color.clear)
                    .listStyle(PlainListStyle())
                    .cornerRadius(10)
                    .padding()
                   .navigationBarTitle("Details of \(strTitle)", displayMode: .inline)
                   .toolbar{
                       ToolbarItem(placement: .topBarTrailing) {
                           Button{
                               CommonFunctions.Functions.getHapticFeedback(impact: .heavy)
               }label:{
                               Image(systemName: "heart.circle").foregroundStyle(Color.red)
                           }
                       }
                      
                   }
                   .navigationBarBackButtonHidden(false)
                
            }
    }
    
    
 
}

#Preview {
    AppetiteDetailView()
}
