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
    let difficulty: String
}
