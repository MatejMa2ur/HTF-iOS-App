//
//  Riddle.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import Foundation

struct Riddle: Codable, Identifiable {
    let id: UUID
    let name: String
    let text: String
    let firstSolved: Date?
    let uploads: [RiddleUpload] // This is assuming you have a corresponding RiddleUpload struct
    let difficulty: String
    let score: Score? // This is assuming you have a corresponding Score struct
}
