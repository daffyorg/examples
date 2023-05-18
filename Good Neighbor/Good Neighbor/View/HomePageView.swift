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
        VStack {
            Text("Welcome to \(viewModel.city)!")
                .font(.title)
                .padding(.vertical, 50)
            ForEach(viewModel.newsArticles) { article in
                Text(article.title)
            }
            Spacer()
        }
        .onAppear {
            viewModel.requestLocation()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: HomeViewModel(locationDataProvider: LocationDataProvider(), daffyDataProvider: DaffyDataProvider()))
    }
}
