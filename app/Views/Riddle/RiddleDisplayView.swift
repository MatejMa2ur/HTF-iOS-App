//
//  RiddleDisplayView.swift
//  app
//
//  Created by Matej Mazur on 21/02/2024.
//

import SwiftUI

struct RiddleDetailView: View {
    let riddle: Riddle
    let dateFormatter = DateFormatter()
    @State private var answer: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text(riddle.name)
                        .font(.title)
                        .bold()
                    
                    if !riddle.uploads.isEmpty {
                        LazyVStack {
                            ForEach(riddle.uploads, id: \.self) { upload in
                                if let url = URL(string: upload.url) {
                                    AsyncImage(
                                        url: url,
                                        scale: 1.0,
                                        content: { image in
                                            image.resizable().scaledToFit()
                                        },
                                        placeholder: {
                                            Text("Loading image...")
                                        }
                                    )
                                    .frame(maxHeight: 200)
                                } else {
                                    Text("Invalid URL")
                                }
                            }
                        }
                        .frame(maxHeight: 300)
                    }
                    
                    Text(riddle.text)
                }
            }
            .frame(maxHeight: .infinity)  // Make ScrollView take all available space
                
            VStack {
                Form{
                    if let score = riddle.score {
                        HStack {
                            Text("Solved at:")
                            Spacer()
                            
                            let dateString = dateFormatter.string(from: score.createdAt)
                            Text(dateString)
                        }
                    } else {
                        TextField("Enter your answer", text: $answer)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // Style to mimic the Form's TextField
                        
                        Button(action: {
                            print("Submitted answer: \(answer)")
                        }) {
                            Text("Submit")
                        }
                    }
                }
            }
        }
    }
}
