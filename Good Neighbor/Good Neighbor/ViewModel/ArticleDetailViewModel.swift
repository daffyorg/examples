//
//  ArticleDetailViewModel.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

enum DonationCompletionStatus: Equatable {
    case needsConfirmation
    case sendingRequest
    case success(title: String = "Donation Succeeded", message: String)
    case failure(title: String = "There was an error", errorMessage: String)
}

class ArticleDetailViewModel: ObservableObject {
    let daffyDataProvider: DaffyDataProviderProtocol

    @Published var article: NewsArticle
    @Published var shouldShowAlert = false
    @Published var donationCompletionStatus: DonationCompletionStatus = .needsConfirmation
    @Published var nonProfits: [String: NonProfit] = [:]
    
    init(article: NewsArticle, daffyDataProvider: DaffyDataProviderProtocol) {
        self.article = article
        self.daffyDataProvider = daffyDataProvider
        
        fetchData()
    }
    
    func fetchData() {
        article.donationRecommendations.forEach { recommendation in
            retrieveNonProfitInformation(ein: recommendation.nonProfitEIN)
        }
    }
    
    func retrieveNonProfitInformation(ein: String) {
        daffyDataProvider.getNonProfit(ein: ein) { result in
            switch result {
            case .success(let success):
                print("Retrieved non profit: \(success)")
                self.nonProfits[ein] = success
            case .failure(let failure):
                print("Failed to retrieve non profits: \(failure)")
            }
        }
    }
    
    func donate(_ amount: Int, nonProfit: NonProfit) {
        donationCompletionStatus = .sendingRequest
        daffyDataProvider.donate(nonProfit: nonProfit, amount: amount) { [weak self] result in
            switch result {
            case .success(let donation):
                self?.donationCompletionStatus = .success(message: "Successfully donated $\(donation.amount) to \(donation.nonProfit.name)!")
                self?.shouldShowAlert = true
            case .failure(let failure):
                self?.shouldShowAlert = false
                self?.donationCompletionStatus = .failure(title: "Failed to make donation", errorMessage: "Unable to make a donation to \(nonProfit.name) for $\(amount). Please try again later.")
            }
            
        }
    }
}
