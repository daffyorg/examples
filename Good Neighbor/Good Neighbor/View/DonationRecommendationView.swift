//
//  DonationRecommendationView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import SwiftUI

struct DonationRecommendationView: View {
    var title: String
    var description: String
    let donationAmounts: [Int]
    let nonProfit: NonProfit
    @ObservedObject var viewModel: ArticleDetailViewModel
    @State var selectedAmount: Int?
    @State var alertIsShowing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(Fonts.subheadlineSFBold)
                .foregroundColor(.neutral900)
            
            Text(description)
                .font(Fonts.footnote)
                .foregroundColor(.neutral700)
                .multilineTextAlignment(.leading)
            
            HStack(spacing: 12) {
                Text("Donate")
                    .foregroundColor(.neutral700)
                    .font(Fonts.footnoteBold)
                ForEach(donationAmounts, id: \.self) { amount in
                    DonationPill(amount: amount, action: {
                        selectedAmount = amount
                        alertIsShowing = true
                    })
                }
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.background)
        .cornerRadius(12)
        .alert(isPresented: $alertIsShowing) {
            var alertTitle = ""
            var alertMessage = ""
            switch viewModel.donationCompletionStatus {
            case .needsConfirmation, .sendingRequest:
                return Alert(
                    title: Text("Confirm Donation"),
                    message: Text("Please confirm a donation amount of $\(selectedAmount ?? 0) to \(title)"),
                    primaryButton: .default(Text("Donate"), action: {
                        if let selectedAmount {
                            viewModel.donate(selectedAmount, nonProfit: nonProfit)
                        }
                    }),
                    secondaryButton: .cancel()
                )
            case let .failure(title: title, errorMessage: errorMessage):
                alertTitle = title
                alertMessage = errorMessage
            case let .success(title: title, message: message):
                alertTitle = title
                alertMessage = message
            }
            return Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .cancel(Text("Dismiss"), action: {
                    viewModel.donationCompletionStatus = .needsConfirmation
                })
            )
        }
        .onAppear {
            subscriptions()
        }
    }
    
    func subscriptions() {
        viewModel.$donationCompletionStatus
            .sink { status in
                switch status {
                case let .success(title: _, message: message):
                    if message.contains(nonProfit.name) {
                        self.alertIsShowing = true
                    }
                default:
                    break
                }
            }.store(in: &viewModel.subscribers)
    }
}

struct DonationPill: View {
    var amount: Int
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("$\(Int(amount))")
                    .foregroundColor(.blue)
                    .font(Fonts.caption1)
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                    .padding(.bottom, 6)
            }
            .background(Color.white)
            .cornerRadius(19)
        }
    }
}

struct DonationRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationRecommendationView(title: Mocks.SaltLakeCity.mockNonProfit1.name, description: Mocks.SaltLakeCity.mockDonationRecommendations.first!.description, donationAmounts: Mocks.SaltLakeCity.mockDonationRecommendations.first!.donationAmounts, nonProfit: Mocks.SaltLakeCity.mockNonProfit1, viewModel: ArticleDetailViewModel(article: Mocks.SaltLakeCity.mockNewsArticle1, daffyDataProvider: DaffyDataProvider()))
    }
}
