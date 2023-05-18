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
    
    var viewModel: ArticleDetailViewModel
    
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
                    DonationPill(amount: amount, action: { viewModel.donate(amount) })
                }
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.background)
        .cornerRadius(12)
        
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
        DonationRecommendationView(title: Mocks.mockDonationRecommendation.nonProfit.name, description: Mocks.mockDonationRecommendation.description, donationAmounts: Mocks.mockDonationRecommendation.donationAmounts, viewModel: ArticleDetailViewModel(article: Mocks.mockNewsArticle1))
    }
}
