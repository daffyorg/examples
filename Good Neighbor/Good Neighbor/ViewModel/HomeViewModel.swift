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
    var timer: Timer?
    var subscribers: Set<AnyCancellable> = []
    
    @Published var newsArticles: [NewsArticle] = []
    @Published var city: String = ""
    @Published var needsAPIKey: Bool = false
    @Published var state: String = ""
    @Published var donations: [Donation] = []
    @Published var apiKeyError: Error?
    @Published var title: String?
    @Published var user: DaffyUser = DaffyUser(name: "Test", id: -1)
    
    init(locationDataProvider: LocationDataProviderProtocol, daffyDataProvider: DaffyDataProviderProtocol) {
        self.locationDataProvider = locationDataProvider
        self.daffyDataProvider = daffyDataProvider
        
        self.locationDataProvider.location
            .compactMap( { $0 } )
            .sink { location in
                if let city = location.city, let state = location.state {
                    if city != self.city, state != self.state {
                        self.city = city
                        self.state = state
                        self.getTitle(user: self.user)
                        self.retrieveArticles(city: city)
                        self.retrieveDonations(city: city, state: state)
                    }
                }
            }.store(in: &subscribers)
        
        $user.sink { [weak self] user in
            self?.getTitle(user: user)
        }.store(in: &subscribers)
        
        daffyDataProvider.donations
            .sink { [weak self] donations in
                self?.donations = donations
            }.store(in: &subscribers)
        
        self.retrieveAPIKey()
        self.requestLocationPermissions()
        self.setLocationTimerUpdate()
        self.reload()
    }
    
    func reload() {
        getUser()
        requestLocationUpdate()
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
                
                self.donations = donationsInLocation.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending })
            case .failure(let failure):
                print("Failed to get donations: \(failure)")
            }
        }
    }
    
    func retrieveArticles(city: String) {
        switch city {
        case "Salt Lake City":
            self.newsArticles = [Mocks.SaltLakeCity.mockNewsArticle1, Mocks.SaltLakeCity.mockNewsArticle2]
        case "Boston":
            self.newsArticles = [Mocks.Boston.mockNewsArticle1, Mocks.Boston.mockNewsArticle2]
        case "San Francisco":
            self.newsArticles = [Mocks.SanFrancisco.mockNewsArticle1, Mocks.SanFrancisco.mockNewsArticle2]
        default:
            self.newsArticles = [Mocks.SaltLakeCity.mockNewsArticle1, Mocks.Boston.mockNewsArticle2, Mocks.SaltLakeCity.mockNewsArticle2, Mocks.Boston.mockNewsArticle1, Mocks.SanFrancisco.mockNewsArticle1, Mocks.SanFrancisco.mockNewsArticle2]
        }
    }
    
    func requestLocationPermissions() {
        locationDataProvider.requestLocationPermissions()
    }
    
    func requestLocationUpdate() {
        locationDataProvider.requestLocationUpdate()
    }
    
    func retrieveAPIKey() {
        if let storedApiKey = UserDefaults.standard.string(forKey: "apiKey") {
            daffyDataProvider.setAPIkey(storedApiKey)
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
            case let .success(user):
                UserDefaults.standard.set(apiKey, forKey: "apiKey")
                self?.needsAPIKey = false
                self?.user = user
            }
        }
    }
    
    func getUser() {
        daffyDataProvider.retrieveMyUser { result in
            switch result {
            case .failure:
                break
            case let .success(user):
                self.user = user
            }
        }
    }
    
    func getTitle(user: DaffyUser) {
        guard !city.isEmpty else {
            title = "Welcome!"
            return
        }
        
        guard let name = user.name.components(separatedBy: " ").first else {
            title = "Welcome to \(city)!"
            return
        }
        
        title = "Welcome to \(city), \(name)!"
    }
    
    func setLocationTimerUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.requestLocationUpdate()
        }
    }
}
