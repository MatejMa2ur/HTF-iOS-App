//
//  UserDefaults+Extensions.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import Foundation

extension UserDefaults {

    func getAuthResponse() -> AuthResponse? {
        guard let savedData = self.data(forKey: "AuthResponse") else { return nil }
        let decoder = JSONDecoder()
        guard let loadedResponse = try? decoder.decode(AuthResponse.self, from: savedData) else { return nil }
        return loadedResponse
    }

    func saveAuthResponse(_ authResponse: AuthResponse) {
        if let encodedData = try? JSONEncoder().encode(authResponse) {
            set(encodedData, forKey: "AuthResponse")
        }
    }
    
    func removeAuthResponse() {
        self.removeObject(forKey: "AuthResponse")
    }
}
