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
            VStack{
                Image("HTF-bold-320-sh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
                if let authResponse = UserDefaults.standard.getAuthResponse() {
                    Text("Hello, \(authResponse.nickname)")
                } else {
                    Text("Log In")
                }
            }
        }
    }
}
