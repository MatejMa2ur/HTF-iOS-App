//
//  RiddleUpload.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import Foundation

struct RiddleUpload: Codable, Identifiable, Hashable {
    let id: UUID
    let url: String
}
