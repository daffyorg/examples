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
    @Published var article: NewsArticle
    @Published var shouldShowAlert = false
    @Published var donationCompletionStatus: DonationCompletionStatus = .needsConfirmation
    
    init(article: NewsArticle) {
        self.article = article
    }
    
    func donate(_ amount: Int, nonProfit: NonProfit) {
        donationCompletionStatus = .sendingRequest
        // Artificial 2 second delay to simulate network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    
            self?.donationCompletionStatus = .success(message: "Successfully donated $\(amount) to \(nonProfit.name)!")
            //        donationCompletionStatus = .failure(title: "There was an error", errorMessage: "Donation could not be completed because you do not have sufficient funds")
            self?.shouldShowAlert = true
        }
    }
}
