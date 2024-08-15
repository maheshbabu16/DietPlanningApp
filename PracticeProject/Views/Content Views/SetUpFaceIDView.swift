//
//  SetUpFaceIDView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 15/08/24.
//

import SwiftUI

struct SetUpFaceIDView: View {
    
    @Binding var isFaceIDAvailable: Bool
    @StateObject var biometry = BiometryManager()
    
    var dismissSheet : (() -> Void)?
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.15))
                            .frame(maxHeight: 200)
                            .padding(.horizontal, 20)
                        VStack{
                            Image(systemName: getImageName())
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color.blueYellowGradient)
                                .padding()
                            
                            Text(isFaceIDSetupCompleted() ? "Face ID setup already completed ": "You can now unlock this app using FaceID. Press below button to setup ")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .bold()
                                .minimumScaleFactor(0.2)
                                .padding()
                            
                        }.padding()
                    }.padding(.top, 20)
                    
                    if !isFaceIDSetupCompleted(){
                        Spacer(minLength: 20)
                        Button{
                            Task{
                                await biometry.startBiometryVerification()
                                if biometry.isAuthenticated{
                                    UserDefaults.standard.setValue(true, forKey: "isFaceIDAvailable")
                                }
                            }

                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                Text("Authenticate")
                                    .bold()
                                    .foregroundStyle(Color.white)
                            }.frame(height: 50)
                        }.padding()
                    }
                }.padding(.vertical)
                    
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismissSheet?()
                    }, label: {
                        Text("Cancel").bold()
                    })
                }
            })
        }
    }
    
    func getImageName() ->String{
        
        if isFaceIDSetupCompleted(){
            return "checkmark.square.fill"
        }else{
            switch biometry.biometryType {
            case .faceID:
                return "faceid"
            case .touchID:
                return "touchid"
            default:
                return "lock.app.dashed"
            }
        }
    }
    
    func isFaceIDSetupCompleted() -> Bool {
        if let available = UserDefaults.standard.object(forKey: "isFaceIDAvailable") as? Bool {
            return available
        }
        return false
    }
}
#Preview {
    SetUpFaceIDView(isFaceIDAvailable: .constant(false))
}
