//
//  RiddleListView.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import SwiftUI

struct RiddleListView: View {
    @State private var riddles: [Riddle] = []
    
    @State private var riddlesByDifficulty: [String: [Riddle]] = [:]

    var body: some View {
        NavigationView {
            if UserDefaults.standard.getAuthResponse() != nil {
                List {
                    ForEach(riddlesByDifficulty.keys.sorted(), id: \.self) { difficulty in
                        Section(header: Text(difficulty)) {
                            ForEach(riddlesByDifficulty[difficulty]!, id: \.id) { riddle in
                                Text(riddle.text)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Riddles")
            } else {
                Text("Log In")
            }
        }
        .onAppear {
            self.loadRiddles { riddles in
                let groupedRiddles = Dictionary(grouping: riddles) { $0.difficulty }
                self.riddlesByDifficulty = groupedRiddles
            }
        }
    }
    
    func loadRiddles(completion: @escaping ([Riddle]) -> ()) {
        guard let url = URL(string: "https://api.610e0fbf72644b8f1bc227448ff795197e48093f.net/Riddle"),
              let authResponse = UserDefaults.standard.getAuthResponse() else { return }
      
        let token = authResponse.token
        print("Authorized with token: \(token)")

        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let riddles = try? decoder.decode([Riddle].self, from: data) {
                    print("Received \(riddles.count) riddles")
                    DispatchQueue.main.async {
                        completion(riddles)
                    }
                } else {
                    print("Failed to decode riddles")
                }
            } else if let error = error {
                print("HTTP request failed: \(error)")
            } else {
                print("No data received")
            }
        }.resume()
    }
}
