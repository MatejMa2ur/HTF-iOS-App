//
//  AuthResponse.swift
//  app
//
//  Created by Matej Mazur on 20/02/2024.
//

import Foundation

struct AuthResponse: Codable {
    var userId: UUID
    var email: String
    var token: String
    var nickname: String
    var roles: [String]
}
