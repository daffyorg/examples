//
//  NewsArticle.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation

public struct NewsArticle: Identifiable {
    public let id: UUID = UUID()
    let title: String
    let content: String
    let city: String
    let donationRecommendations: [DonationRecommendation]
}
