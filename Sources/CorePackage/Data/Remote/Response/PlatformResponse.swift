//
//  Platform.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct Platforms: Codable, Identifiable {
    public let id = UUID()
    public let platform: Platform
}

public struct Platform: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let slug: String
}
