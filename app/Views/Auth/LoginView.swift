//
//  LoginView.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import SwiftUI

struct LoginView: View {

    @State var username = ""
    @State var password = ""
    
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager

    var body: some View {
        NavigationView {
            VStack{
                Image("HTF-bold-320-sh-lg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Form {
                    Section(){
                        TextField("Username", text: $username)
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        let loginRequest = LoginRequest(email: self.username, password: self.password)
                        submitLoginInfo(loginRequest: loginRequest)
                    }, label: {
                        Text("Log In")
                    })
                }
            }
        }
    }
    
    func submitLoginInfo(loginRequest: LoginRequest) {
        guard let apiUrl = URL(string: "https://api.610e0fbf72644b8f1bc227448ff795197e48093f.net/Identity/Auth/Login") else { return }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(loginRequest)
            request.httpBody = requestBody
        } catch let error {
            print("Error occurred while encoding: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let authResponse = try decoder.decode(AuthResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Updating UI on the main thread
                        self.userDefaultsManager.authResponse = authResponse
                    }
                } catch {
                    print("Error while decoding the response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
