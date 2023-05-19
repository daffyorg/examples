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
    @Published var state: String = "UT"
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
                if let city = location.city, let state = location.state {
                    self.city = city
                    self.state = state
                    self.retrieveArticles(city: city)
                    self.retrieveDonations(city: city, state: state)
                }
            }.store(in: &subscribers)
        
        UserDefaults.standard.removeObject(forKey: "apiKey")
        
        self.retrieveAPIKey()
    }
    
    func reload() {
        requestLocation()
        retrieveDonations(city: self.city, state: self.state)
        retrieveArticles(city: self.city)
    }
    
    func retrieveDonations(city: String, state: String) {
        daffyDataProvider.getAllDonations(user: user) { result in
            switch result {
            case .success(let donations):
                let donationsInLocation = donations.filter { donation in
                    donation.nonProfit.state == state && donation.nonProfit.city == city
                }
                
                self.donations = donationsInLocation
            case .failure(let failure):
                print("Failed to get donations: \(failure)")
            }
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
