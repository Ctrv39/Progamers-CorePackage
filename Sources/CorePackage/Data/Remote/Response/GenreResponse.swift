//
//  Genre.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct Genre: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let image: String

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "image_background"
    }
}
