//
//  ArticleDetailView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    
    var body: some View {
        Text(article.title)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: NewsArticle(title: "Test Article", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent a leo id turpis facilisis placerat. Integer ultrices risus et lectus sollicitudin finibus. Vivamus sed interdum odio. Donec congue auctor sapien at lobortis. Pellentesque consectetur odio ac bibendum consequat. Maecenas sagittis mauris et aliquam cursus. Nam mattis euismod metus, in facilisis justo gravida et. Sed feugiat auctor nisl, ac rhoncus libero consectetur ut. Sed sed lacus eu enim lobortis faucibus. Mauris sed faucibus metus, ac eleifend ex. Cras in suscipit magna, sit amet interdum elit. Quisque viverra mi eu ante blandit feugiat. Sed id elit nec purus ultrices efficitur.", city: "Salt Lake City, UT", donationRecommendations: [Mocks.mockDonationRecommendation]))
    }
}
