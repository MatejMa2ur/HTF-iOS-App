//
//  ContentView.swift
//  app
//
//  Created by Matej Mazur on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        if userDefaultsManager.authResponse != nil {
            TabView {
                HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                RiddleListView()
                .tabItem {
                    Label("Riddles", systemImage: "book")
                }
                ScoreboardView()
                .tabItem {
                    Label("Score", systemImage: "square.3.layers.3d.top.filled")
                }
                ProfileView()
                .environmentObject(userDefaultsManager)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            }
        } else {
            // If user is not logged in, show LoginView
            LoginView().environmentObject(userDefaultsManager)
        }
    }
}
