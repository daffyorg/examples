//
//  HomePageView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Spacer()
                                    .frame(height: 58)
                                Text("Welcome to \(viewModel.city)!")
                                    .font(Fonts.largeTitle)
                                    .padding(.bottom, 48)
                                if let lastDonation = viewModel.donations.last {
                                    
                                    let amount = Text("$\(lastDonation.amount)")
                                        .font(Fonts.title3Bold)
                                    let nonProfit = Text(lastDonation.nonProfit.name)
                                        .font(Fonts.title3Bold)
                                    
                                    Text("You donated \(amount) to \(nonProfit)")
                                        .font(Fonts.title3)
                                        .padding(.bottom, 48)
                                }
                            }
                            .foregroundColor(.neutral900)
                            .padding(.leading, 24)
                            Spacer()
                        }
                        .onAppear {
                            viewModel.requestLocation()
                        }
                        Text("NEWS")
                            .kerning(1.8)
                            .font(Fonts.caption1)
                            .foregroundColor(.neutral900)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        ForEach(viewModel.newsArticles) { article in
                            let articleDetailViewModel = ArticleDetailViewModel(article: article, daffyDataProvider: viewModel.daffyDataProvider)
                            
                            NavigationLink(destination: ArticleDetailView(viewModel: articleDetailViewModel)) {
                                NewsPreviewView(title: article.title, subtitle: article.content, imageURL: "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")
                                    .frame(minHeight: 110)
                                    .padding(.bottom, 12)
                                    .padding(.horizontal, 16)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.needsAPIKey) {
            InputView(viewModel: viewModel)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: HomeViewModel(locationDataProvider: LocationDataProvider(), daffyDataProvider: DaffyDataProvider()))
    }
}
