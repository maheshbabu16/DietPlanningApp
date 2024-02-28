//
//  SheduleWorkOutView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 07/02/24.
//

import SwiftUI
import SwiftData

struct SheduleWorkOutView: View {
    
    @State private var userWorkout: [SheduleWorkoutModel] = []
    @State private var presentWorkoutSheet : Bool = false
    @Environment (\.modelContext) var formData
    @State var selectedDay = ""
    @State var selectedWorkoutType = ""
    
    var body: some View {
        NavigationStack{
            ZStack {
                if (userWorkout.count == 0){
                    VStack{
                        Text("Add your data from here")
                            .font(.system(size: 18))
                        
                        Button{
                            self.presentWorkoutSheet.toggle()
                            CommonFunctions.Functions.getHapticFeedback(impact: .light)
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.textColor.opacity(0.15))
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundStyle(Color.blue)
                            }
                        }.frame(width: 40, height: 40).padding(.top, 5)
                    }
                }else {
                    List {
                        ForEach(userWorkout){ item in
                            WorkoutRowCell(workoutModel: item)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                    }.listStyle(PlainListStyle())
                }
            }
            .navigationTitle("My Workout")
            .toolbar(){
                ToolbarItem(placement: .topBarLeading) {
                    if (userWorkout.count != 0){
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "trash")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                            NavigationLink {
                                ImageGalleryView()
                            } label: {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .foregroundStyle(Color.btnGradientColor)
                            }

                        
                        
                        if (userWorkout.count != 0){
                            Button{
                                self.presentWorkoutSheet.toggle()
                                CommonFunctions.Functions.getHapticFeedback(impact: .light)
                            }label: {
                                Image(systemName: "plus.app")
                                    .foregroundStyle(Color.btnGradientColor)
                            }
                        }
                    }
                }
            }
        }.sheet(isPresented: $presentWorkoutSheet, onDismiss: {
            fetchData()
        }, content: {
            AddWorkoutSheduleView(strSelectedType: $selectedWorkoutType, sheduleChart: $userWorkout) {
                self.presentWorkoutSheet.toggle()
            }
                .presentationDetents([.fraction(0.75), .large])
        })
    }
    
    func fetchData(){
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
    func deletCalorieChart(){
        do {
            let userID =  UserDefaults.standard.value(forKey: "UserID") as! String
            try formData.delete(model: SheduleWorkoutModel.self, where: #Predicate { workout in
                workout.userID == userID
            })
        }
        catch {
            print("Failed to clear all data.")
        }
    }
}

#Preview {
    SheduleWorkOutView()
}
