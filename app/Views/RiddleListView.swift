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
                        Section(header: 
                        HStack {
                            Text(difficulty)
                            Spacer()
                                Text("\(riddlesByDifficulty[difficulty]!.filter { $0.score != nil }.count) out of \(riddlesByDifficulty[difficulty]!.count)")
                        }
                        ) {
                            ForEach(riddlesByDifficulty[difficulty]!, id: \.id) { riddle in
                                NavigationLink(destination: RiddleDetailView(riddle: riddle)) {
                                    HStack {
                                        Text(riddle.name)
                                        Spacer()
                                        if riddle.score != nil {
                                            Text("✓")
                                                .foregroundColor(.accentColor)
                                        }
                                    }
                                }
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
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSxxx"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                do {
                    let riddles = try decoder.decode([Riddle].self, from: data)
                    print("Received \(riddles.count) riddles")
                    DispatchQueue.main.async {
                        completion(riddles)
                    }
                } catch { 
                    print("Failed to decode riddle JSON: \(error)") }
                
            } else if let error = error {
                print("HTTP request failed: \(error)")
            } else {
                print("No data received")
            }
        }.resume()
    }
}
