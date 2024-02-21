//
//  Score.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import Foundation

struct Score: Codable {
    let riddleId: UUID
    let userId: UUID
    let hash: String
    let createdAt: Date
}
