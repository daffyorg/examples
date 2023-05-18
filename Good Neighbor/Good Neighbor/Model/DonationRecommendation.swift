//
//  NewsArticleDonationRecommendation.swift
//  Good Neighbor
//
//  Created by dita on 5/18/23.
//

import Foundation

public struct DonationRecommendation: Codable, Identifiable {
    // Description of why this donation recommendation works for the article
    public let id = UUID()
    let description: String
    let nonProfit: NonProfit
    // Donation $ amount options to suggest
    let donationAmounts: [Int]
}
