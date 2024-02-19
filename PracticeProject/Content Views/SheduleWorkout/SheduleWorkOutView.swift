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
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Add your data from here")
                    .font(.system(size: 18))
                
                if (userWorkout.count == 0){
                    Button{
                        self.presentWorkoutSheet.toggle()
                        CommonFunctions.Functions.getHapticFeedback(impact: .light)
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.textColor.opacity(0.15))
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color.blue)
                        }
                    }.frame(width: 90, height: 30).padding(.top, 5)
                }
            }
            .navigationTitle("My Workout")
            .toolbar(){
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        
                    }label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundStyle(Color.btnGradientColor)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
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
        }.sheet(isPresented: $presentWorkoutSheet, onDismiss: {
            
        }, content: {
            AddWorkoutSheduleView()
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
}

#Preview {
    SheduleWorkOutView()
}
