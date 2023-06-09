//
//  DaffyDataProvider.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation
import SystemConfiguration
import Combine

public protocol DaffyDataProviderProtocol {
    // MARK: Set API key
    func setAPIkey(_ key: String)
    
    // MARK: Donations
    func getDonation(user: DaffyUser, donationId: Int, completion:@escaping (Result<Donation, Error>) -> ())
    func getAllDonations(user: DaffyUser, completion:@escaping (Result<[Donation], Error>) -> ())
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Result<Donation, Error>) -> ())
    
    // MARK: Users
    func retrieveMyUser(completion:@escaping (Result<DaffyUser, Error>) -> ())
    
    // MARK: Non profits
    func searchNonProfits(query: String, completion:@escaping (Result<[NonProfit], Error>) -> ())
    func getNonProfit(ein: String, completion:@escaping (Result<NonProfit, Error>) -> ())
}

class DaffyDataProvider: DaffyDataProviderProtocol {
    
    private let daffyOrgUrl: String = "https://public.daffy.org/v1"
    private var apiKey: String? = UserDefaults.standard.string(forKey: "apiKey")
    var donations: [Donation] = []
    
    func setAPIkey(_ key: String) {
        self.apiKey = key
    }
    
    func getDonation(user: DaffyUser, donationId: Int, completion:@escaping (Result<Donation, Error>) -> ()) {
        makeRequest(path: "/users/\(user.id)/donations/\(donationId)", method: "GET", completion: completion)
    }
    
    // TODO: Implement get donation method
    func getAllDonations(user: DaffyUser, completion:@escaping (Result<[Donation], Error>) -> ()) {
        completion(.success(donations))
    }
    
    // TODO: Implement create donation method
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Result<Donation, Error>) -> ()) {
        let donation = Donation(id: Int.random(in: 1..<200), nonProfit: nonProfit, amount: amount, note: "For upholding the community", createdAt: Date.now)
        
        // Artificial 1 second delay to simulate network call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            print("Created fake donation: \(donation)")
            self.donations.append(donation)
            completion(.success(donation))
        }
    }
    
    func retrieveMyUser(completion:@escaping (Result<DaffyUser, Error>) -> ()) {
        makeRequest(path: "/users/me", method: "GET", completion: completion)
    }
    
    func searchNonProfits(query: String, completion:@escaping (Result<[NonProfit], Error>) -> ()) {
        makeRequest(path: "/non_profits?query=\(query)", method: "GET") { (result: Result<PaginatedResponse<NonProfit>, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success.items))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getNonProfit(ein: String, completion:@escaping (Result<NonProfit, Error>) -> ()) {
        makeRequest(path: "/non_profits/\(ein)", method: "GET", completion: completion)
    }
    
    private func makeRequest<T : Codable>(path: String, method: String, completion:@escaping (Result<T, Error>) -> ()) {
        let urlBuilder = URLComponents(string: "\(daffyOrgUrl)\(path)")
        
        guard let url = urlBuilder?.url, let apiKey = apiKey else {
            print("Failed to construct URL or retrieve API key")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while making request to \(path): \(error)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = "Error with the response, unexpected status code: \(String(describing: response))"
                print(errorMessage)
                completion(.failure(errorMessage))
                return
            }
            
            if let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            }
        }.resume()
    }
}

private struct PaginatedResponse<T : Codable>: Codable {
    let meta: Page
    let items: [T]
}

private struct Page: Codable {
    let count: Int
    let page: Int
    let last: Int
}

extension String: Error {}
