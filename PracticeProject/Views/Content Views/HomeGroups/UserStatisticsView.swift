//
//  UserStatisticsView.swift
//  PracticeProject
//
//  Created by Mahesh on 01/03/24.
//

import SwiftUI
import SwiftData
import Charts

struct UserStatisticsView: View {
    @Environment(\.modelContext) var formData
    @State var totalCaloriesStr : String = "0"
    @State private var drawingStroke = false

    @State private var foodDataStorage : [CalorieModel] = []
    @State private var userWorkout     : [SheduleWorkoutModel] = []
    @State var chartData               : [UserChart] = []

    var totalCalories: Int {
        foodDataStorage.reduce(0) { $0 + (Int($1.calCount) ) }
    }
    
    let animation = Animation
           .easeOut(duration: 3)
           .delay(0.5)
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
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
            
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(lineWidth: 25)
                                .fill(.pink.opacity(0.35))
                                .padding(20)
                                .overlay {
                                    Circle()
                                        .trim(from: 0, to: drawingStroke ? 4/7 : 0)
                                        .stroke(.pink,
                                                style: StrokeStyle(lineWidth: 25, lineCap: .round))
                                        .padding(20)
                                }
                                .rotationEffect(.degrees(-90))
                                .animation(animation, value: drawingStroke)
                                .onAppear {
                                    drawingStroke.toggle()
                                }
                                
                                    /*animation(.easeInOut(duration: 10).repeatForever(autoreverses: false), value: false)*/
                    
                              
                        }.padding()
                    }.frame(height: 185)
                        .listRowSeparator(.hidden)
                }header: {
                        Text("Your Activity")
                            .bold()
                            .font(.title2)
                            .foregroundStyle(Color.textColor)
                }
                
                Section{
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.textColor.opacity(0.1))
                                HStack(spacing: 10){
                                    ForEach(userWorkout){ user in
                                        VStack(spacing:10){
                                            Text("\(user.day)")
                                                .font(.system(size: 8))
                                                .bold()
                                                .minimumScaleFactor(0.002)
                                            Circle()
                                                .fill(user.workoutType != "Rest" ? Color.green : Color.red)
                                                .frame(height: 10)
                                        }
                                    }
                                }.padding(.vertical)
                                .padding(.horizontal, 10)
                        }.frame(height: 100)
                        
                        HStack{
                            HStack{
                                Circle()
                                    .fill(Color.green)
                                    .frame(height: 10)
                                Text("Regular")
                                    .font(.system(size: 14))
                                    .bold()
                                    .minimumScaleFactor(0.002)
                            }
                            HStack{
                                Circle()
                                    .fill(Color.red)
                                    .frame(height: 10)
                                Text("Rest")
                                    .font(.system(size: 14))
                                    .bold()
                                    .minimumScaleFactor(0.002)

                            }.padding(.horizontal)
                            Spacer()
                        }.padding(.horizontal)
                    }
                    .listRowSeparator(.hidden)
                }header: {
                    Text("Shedule")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                    
                }
                
                Section{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.textColor.opacity(0.1))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        if foodDataStorage.count > 0{
                            Chart{
                                ForEach(foodDataStorage){ data in
                                    
                                    BarMark(x: .value("Food", data.name), y: .value("Calories", data.calCount))
                                        .foregroundStyle(Color.titleGradientColor)
                                }
                            }.padding()
                        } else {
                            Text("Add your diet chart to show data.")
                                .bold()
                        }
                    }.frame(height: foodDataStorage.count > 0 ? 300 : 200)
                    .listRowSeparator(.hidden)
                }header: {
                    Text("Calorie graph")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.textColor)
                    
                }
            }.listStyle(PlainListStyle())
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            addChartData()
            fetchCalData()
            fetchWorkoutData()
            totalCaloriesStr = foodDataStorage.count > 0 ? String(totalCalories) : "0"
        })

    }
}
#Preview {
    UserStatisticsView()
        .preferredColorScheme(.dark)
}
struct RingAnimation: View {
    @State private var drawingStroke = false
 
    let strawberry = Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    let ice = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
 
    let animation = Animation
        .easeOut(duration: 3)
//        .repeatForever(autoreverses: false)
    
        .delay(0.5)
 
    var body: some View {
        ZStack {
            Color.black
            ring(for: strawberry)
                .frame(width: 164)
            ring(for: lime)
                .frame(width: 128)
            ring(for: ice)
                .frame(width: 92)
        }
        .animation(animation, value: drawingStroke)
        .onAppear {
            drawingStroke.toggle()
        }
    }
 
    func ring(for color: Color) -> some View {
        // Background ring
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay {
                // Foreground ring
                Circle()
                    .trim(from: 0, to: drawingStroke ? 4/7 : 0)
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}

extension UserStatisticsView{
    
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
    func fetchWorkoutData(){
        let userID =  UserDefaults.standard.value(forKey: "UserID") as! String
        let descriptor = FetchDescriptor<SheduleWorkoutModel>(predicate: #Predicate { data in
            data.userID == userID
        })
        do {
            userWorkout = try formData.fetch(descriptor)
            print(userWorkout)
        }catch {
            print(error)
        }
    }
    func addChartData(){
        chartData = [
        UserChart(day: "Monday", time: 1),
        UserChart(day: "Tuesday", time: 4),
        UserChart(day: "Wednesday", time: 3),
        UserChart(day: "Thusday", time: 10),
        UserChart(day: "Friday", time: 3),
        UserChart(day: "Saturday", time: 1),
        UserChart(day: "Sunday", time: 5)
        ]
    }
}

