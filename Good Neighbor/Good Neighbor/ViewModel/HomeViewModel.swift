//
//  HomeViewModel.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    let locationDataProvider: LocationDataProviderProtocol
    let daffyDataProvider: DaffyDataProviderProtocol
    var subscribers: Set<AnyCancellable> = []
    
    @Published var newsArticles: [NewsArticle] = [
        NewsArticle(title: "News 1", content: """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ultrices nunc sit amet ullamcorper convallis. Maecenas finibus risus id tristique finibus. Mauris vitae lectus nec leo dignissim efficitur. Sed at mi nec dui rutrum aliquet. Sed id mauris vitae libero auctor consectetur.
                    
                    Nulla fermentum lectus augue, in feugiat dolor faucibus ut. Etiam condimentum lobortis magna. Aliquam consequat diam ligula, id cursus neque commodo non. Curabitur interdum lectus vitae leo viverra bibendum. Quisque scelerisque lacus id odio pharetra rhoncus. Suspendisse potenti.
                    
                    Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam vulputate lectus in elit faucibus, vitae luctus massa commodo. Nunc feugiat consectetur risus, a consequat nisl pulvinar ut. Sed feugiat tincidunt metus, ac viverra neque tristique a.
                    """, city: "Los Angeles, CA", recommendedNonProfits: []),
        NewsArticle(title: "News 2", content: """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ultrices nunc sit amet ullamcorper convallis. Maecenas finibus risus id tristique finibus. Mauris vitae lectus nec leo dignissim efficitur. Sed at mi nec dui rutrum aliquet. Sed id mauris vitae libero auctor consectetur.
                    
                    Nulla fermentum lectus augue, in feugiat dolor faucibus ut. Etiam condimentum lobortis magna. Aliquam consequat diam ligula, id cursus neque commodo non. Curabitur interdum lectus vitae leo viverra bibendum. Quisque scelerisque lacus id odio pharetra rhoncus. Suspendisse potenti.
                    
                    Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam vulputate lectus in elit faucibus, vitae luctus massa commodo. Nunc feugiat consectetur risus, a consequat nisl pulvinar ut. Sed feugiat tincidunt metus, ac viverra neque tristique a.
                    """, city: "Salt Lake City, UT", recommendedNonProfits: []),
        NewsArticle(title: "News 3", content: """
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ultrices nunc sit amet ullamcorper convallis. Maecenas finibus risus id tristique finibus. Mauris vitae lectus nec leo dignissim efficitur. Sed at mi nec dui rutrum aliquet. Sed id mauris vitae libero auctor consectetur.
                    
                    Nulla fermentum lectus augue, in feugiat dolor faucibus ut. Etiam condimentum lobortis magna. Aliquam consequat diam ligula, id cursus neque commodo non. Curabitur interdum lectus vitae leo viverra bibendum. Quisque scelerisque lacus id odio pharetra rhoncus. Suspendisse potenti.
                    
                    Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam vulputate lectus in elit faucibus, vitae luctus massa commodo. Nunc feugiat consectetur risus, a consequat nisl pulvinar ut. Sed feugiat tincidunt metus, ac viverra neque tristique a.
                    """, city: "Austin, TX", recommendedNonProfits: []),
    ]
    
    @Published var city: String = "Salt Lake City"
    @Published var donations: [Donation] = [
        Donation(amount: 50, date: Date.now, nonProfit: NonProfit(id: 999, name: "Salt Lake City Homeless Shelter", ein: 20392))
    ]
    
    init(locationDataProvider: LocationDataProviderProtocol, daffyDataProvider: DaffyDataProviderProtocol) {
        self.locationDataProvider = locationDataProvider
        self.daffyDataProvider = daffyDataProvider
        
        self.locationDataProvider.location
            .compactMap( { $0 } )
            .sink { location in
                if let city = location.city {
                    self.city = city
                }
            }.store(in: &subscribers)
    }
    
    func requestLocation() {
        locationDataProvider.requestLocation()
    }
}
