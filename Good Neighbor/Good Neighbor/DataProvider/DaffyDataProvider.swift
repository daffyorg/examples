//
//  DaffyDataProvider.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/17/23.
//

import Foundation
import SystemConfiguration

public protocol DaffyDataProviderProtocol {
    
    // TODO: Add API methods
    
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Bool) -> ())
    func searchNonProfits(query: String, completion:@escaping ([NonProfit]) -> ())
    func getNonProfit(ein: String, completion:@escaping (NonProfit) -> ())
}

class DaffyDataProvider: DaffyDataProviderProtocol {
    private let daffyOrgUrl: String = "https://api.daffy.org"
    private let apiKey: String? = Bundle.main.object(forInfoDictionaryKey: "DAFFY_API_KEY") as? String
    
    // TODO: Implement API methods
    
    func donate(nonProfit: NonProfit, amount: Int, completion:@escaping (Bool) -> ()) {
        
    }
    
    func searchNonProfits(query: String, completion:@escaping ([NonProfit]) -> ()) {
        makeRequest(path: "/public/api/v1/non_profits?query=\(query)", method: "GET", completion: completion)
    }
    
    func getNonProfit(ein: String, completion:@escaping (NonProfit) -> ()) {
        makeRequest(path: "/public/api/v1/non_profits/\(ein)", method: "GET", completion: completion)
    }
    
    private func makeRequest<T : Decodable>(path: String, method: String, completion:@escaping (T) -> ()) {
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
