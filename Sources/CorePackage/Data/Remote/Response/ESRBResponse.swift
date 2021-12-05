//
//  ESRB.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct ESRB: Codable {
    public var itemId: Int
    public var name: String
    public var slug: String
    public enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case name, slug
    }
}
