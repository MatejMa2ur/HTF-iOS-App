//
//  UserDefaultsManager.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import SwiftUI

class UserDefaultsManager: ObservableObject {
    @Published var authResponse: AuthResponse? {
        didSet {
            if let authResponse = authResponse {
                UserDefaults.standard.saveAuthResponse(authResponse)
            }
        }
    }
    
    init() {
        if let authResponse = UserDefaults.standard.getAuthResponse() {
            self.authResponse = authResponse
            print("Initialization successful: \(authResponse)")
        } else {
            print("Initialization failed: AuthResponse could not be decoded or doesn't exist.")
        }
    }
}
