//
//  Donation.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

public struct Donation: Codable {
    let id: Int
    let nonProfit: NonProfit
    let amount: Int
    var note: String = ""
    let createdAt: Date
}
