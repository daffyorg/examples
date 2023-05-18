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
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 58)
                    Text("Welcome to \(viewModel.city)!")
                        .font(Fonts.largeTitle)
                        .padding(.bottom, 48)
                    Text("You donated $\(20) to \("Monterey Bay Aquarium")")
                        .font(Fonts.title3)
                        .padding(.bottom, 48)
                }
                .padding(.leading, 24)
                Spacer()
            }
            .onAppear {
                viewModel.requestLocation()
            }
            ForEach(viewModel.newsArticles) { article in
                Text(article.title)
                    .padding(.leading)
            }
            Spacer()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: HomeViewModel(locationDataProvider: LocationDataProvider(), daffyDataProvider: DaffyDataProvider()))
    }
}
