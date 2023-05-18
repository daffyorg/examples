//
//  NonProfit.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation

public struct NonProfit: Codable {
    let id: Int
    let name: String
    let ein: String
    let website: String
    let city: String
    let state: String
}
