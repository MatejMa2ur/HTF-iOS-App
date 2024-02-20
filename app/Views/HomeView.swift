//
//  HomeView.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            if let authResponse = UserDefaults.standard.getAuthResponse() {
                Text("Hello, \(authResponse.nickname)")
            } else {
                Text("Log In")
            }
        }
    }
}
