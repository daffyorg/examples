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
    @Published var donations: [Donation] = []
    // TODO: Load actual user with retrieveMyUser
    @Published var user: DaffyUser = DaffyUser(name: "Test", id: -1)
    
    init(locationDataProvider: LocationDataProviderProtocol, daffyDataProvider: DaffyDataProviderProtocol) {
        self.locationDataProvider = locationDataProvider
        self.daffyDataProvider = daffyDataProvider
        
        self.locationDataProvider.location
            .compactMap( { $0 } )
            .sink { location in
                if let city = location.city {
                    self.city = city
                    self.retrieveArticles(city: city)
                    self.retrieveDonations(city: city)
                }
            }.store(in: &subscribers)
    }
    
    func retrieveDonations(city: String) {
        switch city {
        case "Salt Lake City":
            self.donations = [Mocks.SaltLakeCity.mockDonation]
        case "Boston":
            self.donations = [Mocks.Boston.mockDonation]
        case "San Francisco":
            self.donations = [Mocks.SanFrancisco.mockDonation]
        default:
            self.donations = []
        }
    }
    
    func retrieveArticles(city: String) {
        switch city {
        case "Salt Lake City":
            self.newsArticles = [Mocks.SaltLakeCity.mockNewsArticle1]
        case "Boston":
            self.newsArticles = [Mocks.Boston.mockNewsArticle1]
        case "San Francisco":
            self.newsArticles = [Mocks.SanFrancisco.mockNewsArticle1]
        default:
            self.newsArticles = []
        }
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
