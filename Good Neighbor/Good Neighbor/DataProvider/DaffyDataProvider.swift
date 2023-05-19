//
//  DaffyDataProvider.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation
import SystemConfiguration

public protocol DaffyDataProviderProtocol {
    // MARK: Set API key
    func setAPIkey(_ key: String)
    
    // MARK: Donations
    func getDonation(user: DaffyUser, donationId: Int, completion:@escaping (Donation) -> ())
    func getAllDonations(user: DaffyUser, completion:@escaping ([Donation]) -> ())
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Bool) -> ())
    
    // MARK: Users
    func retrieveMyUser(completion:@escaping (DaffyUser) -> ())
    
    // MARK: Non profits
    func searchNonProfits(query: String, completion:@escaping ([NonProfit]) -> ())
    func getNonProfit(ein: String, completion:@escaping (NonProfit) -> ())
}

class DaffyDataProvider: DaffyDataProviderProtocol {
    
    private let daffyOrgUrl: String = "https://api.daffy.org"
    private var apiKey: String?
    
    func setAPIkey(_ key: String) {
        self.apiKey = key
    }
    
    func getDonation(user: DaffyUser, donationId: Int, completion:@escaping (Donation) -> ()) {
        makeRequest(path: "/public/api/v1/users/\(user.id)/donations/\(donationId)", method: "GET", completion: completion)
    }
    
    func getAllDonations(user: DaffyUser, completion:@escaping ([Donation]) -> ()) {
        makeRequest(path: "/public/api/v1/users/\(user.id)/donations", method: "GET") { (paginatedResponse: PaginatedResponse<Donation>) in
                completion(paginatedResponse.items)
        }
    }
    
    // TODO: Implement create donation method
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Bool) -> ()) {
        
    }
    
    func retrieveMyUser(completion:@escaping (DaffyUser) -> ()) {
        makeRequest(path: "/public/api/v1/users/me", method: "GET", completion: completion)
    }
    
    func searchNonProfits(query: String, completion:@escaping ([NonProfit]) -> ()) {
        makeRequest(path: "/public/api/v1/non_profits?query=\(query)", method: "GET") { (paginatedResponse: PaginatedResponse<NonProfit>) in
            completion(paginatedResponse.items)
        }
    }
    
    func getNonProfit(ein: String, completion:@escaping (NonProfit) -> ()) {
        makeRequest(path: "/public/api/v1/non_profits/\(ein)", method: "GET", completion: completion)
    }
    
    private func makeRequest<T : Codable>(path: String, method: String, completion:@escaping (T) -> ()) {
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
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded)
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
