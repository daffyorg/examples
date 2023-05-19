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
    var donationRecommendations: [DonationRecommendation] = []
    let nonProfitEINList: [String]
    
    mutating func createDonationRecommendation(nonProfit: NonProfit) {
        var description = ""
        var donationAmounts: [Int] = []
        switch city {
        case "Salt Lake City, UT":
            let foundRecommendation = Mocks.SaltLakeCity.mockDonationRecommendations.first(where: { $0.nonProfit.ein == nonProfit.ein })
            description = foundRecommendation?.description ?? ""
            donationAmounts = foundRecommendation?.donationAmounts ?? []
        case "San Fransisco, CA":
            let foundRecommendation = Mocks.SanFrancisco.mockDonationRecommendations.first(where: { $0.nonProfit.ein == nonProfit.ein })
            description = foundRecommendation?.description ?? ""
            donationAmounts = foundRecommendation?.donationAmounts ?? []
        case "Boston, MA":
            let foundRecommendation = Mocks.Boston.mockDonationRecommendations.first(where: { $0.nonProfit.ein == nonProfit.ein })
            description = foundRecommendation?.description ?? ""
            donationAmounts = foundRecommendation?.donationAmounts ?? []
        default:
            break
        }
        let donationRecommendation = DonationRecommendation(description: description, nonProfit: nonProfit, donationAmounts: donationAmounts)
        donationRecommendations.append(donationRecommendation)
    }
}
