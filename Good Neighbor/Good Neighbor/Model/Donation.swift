//
//  Donation.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

public struct Donation {
    let id = UUID()
    let amount: Int
    let date: Date
    let nonProfit: NonProfit
}
