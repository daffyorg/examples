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
    @Published var needsAPIKey: Bool = false
    @Published var donations: [Donation] = []
    @Published var apiKeyError: Error?
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
        
        self.retrieveAPIKey()
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
    
    func retrieveAPIKey() {
        if let storedApiKey = UserDefaults.standard.string(forKey: "apiKey") {
            daffyDataProvider.setAPIkey(storedApiKey)
            self.requestLocation()
        } else {
            needsAPIKey = true
        }
    }
    
    func handleAPIKey(_ apiKey: String) {
        daffyDataProvider.setAPIkey(apiKey)
        daffyDataProvider.retrieveMyUser { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.apiKeyError = error
                }
            case .success(_):
                UserDefaults.standard.set(apiKey, forKey: "apiKey")
                self?.needsAPIKey = false
            }
        }
    }
}
