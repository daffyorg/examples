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
    
    @Published var newsArticles: [NewsArticle] = []
    @Published var city: String = "Salt Lake City"
    @Published var donations: [Donation] = [
        Mocks.mockDonation
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
    
    func retrieveArticles() {
        self.newsArticles = [
//            NewsArticle(
//                title: "Bring the kids to the annual Duckling Day Parade on Boston Common",
//                content:
//                    """
//                    Duckling Day returns to Boston Common and the Public Garden on Sunday, May 14, celebrating Mother’s Day and Robert McCloskey’s beloved book “Make Way for Ducklings.” For over 30 years, hundreds of children dressed like characters from the book have headed to the Common with their families for a day of children’s activities, parading, and warm weather fun.
//
//                    Festivities kick off at 10 a.m. on Boston Common near the Parkman Bandstand with “Playtime on the Common.” Children can play interactive circus games with Esh Circus Arts, see a magician, check out the “Make Way for Ducklings” reading station, and visit with the Harvard University Marching Band.
//
//                    The parade begins at noon, marching from the bandstand through the Common and Public Garden and ending at the “Make Way for Ducklings” statues. Last year’s Duckling Day was the biggest one yet, with thousands attending the sold-out event.
//
//                    Registration costs $35 per child and includes a goodie back full of Duckling Day-themed gifts. Families are encouraged to bring a picnic lunch to enjoy in the Public Garden after the festivities end.
//                    """,
//                city: "Boston, MA",
//                donationRecommendations: [
//                    DonationRecommendation(
//                        description:
//                        """
//                        The mission of the Friends of the Public Garden is to preserve, protect and enhance Boston's first public parks - the Boston Common, the Public Garden and the Commonwealth Avenue Mall - in partnership with the City of Boston's Parks and Recreation Department.
//                        """,
//                        nonProfit: retrieveNonProfit(ein: "237451432")!,
//                        donationAmounts: [20, 40, 100]
//                    )
//                ]
//            ),
            Mocks.mockNewsArticle1
        ]
    }
    
    func requestLocation() {
        locationDataProvider.requestLocation()
    }
    
    func retrieveNonProfit(ein: String) -> NonProfit? {
        var result: NonProfit? = nil
        
        daffyDataProvider.getNonProfit(ein: ein) { nonProfit in
            print("Received non-profit: \(nonProfit)")
            result = nonProfit
        }
        
        return result
    }
}
