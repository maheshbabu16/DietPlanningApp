//
//  ThemePrefrenceIntroView.swift
//  PracticeProject
//
//  Created by Mahesh on 01/03/24.
//

import SwiftUI

struct ThemePrefrenceIntroView: View {
    
    @State private var selectedButtonTag : Int = 0
    var body: some View {
        VStack{
            Text("Select Color Scheme")
                .font(.title)
                .bold()
            
            VStack(spacing: 0){
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.textColor.opacity(0.10))
                            .stroke(selectedButtonTag == 0 ? Color.blue : Color.clear, lineWidth: 2.5)
                        HStack{
                            HStack{
                                Image(systemName: selectedButtonTag == 0 ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedButtonTag == 0 ? Color.blue : Color.gray)
                                Text("Auto")
                                    .foregroundStyle(Color.textColor)
                                    .bold()
                            }.padding()
                            Spacer()
                            ZStack{
                                Image(systemName: "apps.iphone")
                                    .resizable()
                                    .foregroundStyle(Color.btnGradientColor)
                                    .scaledToFit()
                                    .padding()
                            }.frame(height: 60)
                        }
                    }.onTapGesture(perform: {
                        selectedButtonTag = 0
                        changeDeviceTheme(mode: .light)

                    })
                    .frame(height: 100)
                    
                }.padding(.horizontal)
                .padding(.vertical, 10)
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.textColor.opacity(0.10))
                            .stroke(selectedButtonTag == 1 ? Color.blue : Color.clear, lineWidth: 2.5)
                        HStack{
                            HStack{
                                Image(systemName: selectedButtonTag == 1 ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedButtonTag == 1 ? Color.blue : Color.gray)
                                Text("Light Mode")
                                    .foregroundStyle(Color.textColor)
                                    .bold()
                            }.padding()
                            Spacer()
                            ZStack{
                                Image(systemName: "sun.min.fill")
                                    .resizable()
                                    .foregroundStyle(Color.orange)
                                    .scaledToFit()
                                    .padding()
                            }.frame(height: 60)
                        }
                    }.onTapGesture(perform: {
                        selectedButtonTag = 1
                        changeDeviceTheme(mode: .light)

                    })
                    .frame(height: 100)
                    
                }.padding(.horizontal)
                    .padding(.vertical, 10)
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.textColor.opacity(0.10))
                            .stroke(selectedButtonTag == 2 ? Color.blue : Color.clear, lineWidth: 2.5)
                        
                        HStack{
                            HStack{
                                Image(systemName: selectedButtonTag == 2 ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedButtonTag == 2 ? Color.blue : Color.gray)
                                Text("Dark Mode")
                                    .foregroundStyle(Color.textColor)
                                    .bold()
                            }.padding()
                            Spacer()
                            ZStack{
                                Image(systemName: "moon.stars")
                                    .resizable()
                                    .foregroundStyle(Color.textGradient)
                                    .scaledToFit()
                                    .padding()
                            }.frame(height: 60)
                        }
                    }.onTapGesture(perform: {
                        selectedButtonTag = 2
                        changeDeviceTheme(mode: .dark)
                    })
                    .frame(height: 100)
                }.padding(.horizontal)
                    .padding(.vertical, 10)
            }.padding()
        }
    }
}

extension ThemePrefrenceIntroView{
     func changeDeviceTheme(mode: UIUserInterfaceStyle){
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }
}
#Preview {
        ThemePrefrenceIntroView()
}
