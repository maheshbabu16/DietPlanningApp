//
//  BiometryManager.swift
//  PracticeProject
//
//  Created by Mahesh babu on 13/08/24.
//

import Foundation
import LocalAuthentication

class BiometryManager: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var biometryType: LABiometryType = .none
    @Published var showErrorMessage: Bool = false
    
    private (set) var canEvaluatePolicy = false
    var context = LAContext()
    var error: NSError?
    
    init() {
        getBioMetricType()
    }
    
    func getBioMetricType() {
        self.canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        self.biometryType = context.biometryType
    }
    
    func startBiometryVerification () async {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                
                if success == true{
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                    print("FacIDSuccessfull")
                }
            } catch  {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showErrorMessage = true
                    self.isAuthenticated = false
                }
            }
        }
    }
}

