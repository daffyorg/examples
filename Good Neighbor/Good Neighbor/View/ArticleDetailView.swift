//
//  ArticleDetailView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import SwiftUI

struct ArticleDetailView: View {
    @ObservedObject var viewModel: ArticleDetailViewModel
    
    var body: some View {
        ZStack {
            Color.background2
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.article.title)
                        .font(Fonts.largeTitleBold)
                        .foregroundColor(.neutral900)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                    Text(viewModel.article.content)
                        .foregroundColor(.neutral700)
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                    Text("Recommended Non-Profits".uppercased())
                        .font(Fonts.caption1)
                        .kerning(1.6)
                        .foregroundColor(.neutral900)
                        .padding(.horizontal, 24)
                        .padding(.top, 48)
                        .padding(.bottom, 12)
                    ForEach(viewModel.article.donationRecommendations) { recommendation in
                        DonationRecommendationView(title: recommendation.nonProfit.name, description: recommendation.description, donationAmounts: recommendation.donationAmounts, nonProfit: recommendation.nonProfit, viewModel: viewModel)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 12)
                    }
                }
            }
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(
            viewModel: ArticleDetailViewModel(
                article: Mocks.Boston.mockNewsArticle1,
                daffyDataProvider: DaffyDataProvider()
            )
        )
    }
}
