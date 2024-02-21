//
//  ProfileView.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    Text("User: \(userDefaultsManager.authResponse?.email ?? "")")
                    Text("Nickname: \(userDefaultsManager.authResponse?.nickname ?? "")")
                }
                
                Button(action: {
                    userDefaultsManager.authResponse = nil
                }, label: {
                    Text("Logout")
                })
            }
        }
    }
}
