//
//  ArticleDetailViewModel.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import Foundation

class ArticleDetailViewModel: ObservableObject {
    @Published var article: NewsArticle
    
    init(article: NewsArticle) {
        self.article = article
    }
    
    func donate(_ amount: Int) {
        
    }
}
