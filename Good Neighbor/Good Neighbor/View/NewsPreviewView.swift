//
//  NewsPreviewView.swift
//  Good Neighbor
//
//  Created by Brielle Petrie on 5/18/23.
//

import SwiftUI

struct NewsPreviewView: View {
    var title: String
    var subtitle: String
    var imageURL: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .overlay(
                HStack(spacing: 15) {
                    loadImageFromURL()
                        .resizable()
                        .frame(width: 72, height: 72)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .foregroundColor(.black)
                            .font(Fonts.subheadlineBold)
                        
                        Text(subtitle)
                            .font(Fonts.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                }
                .padding(16)
            )
    }
    
    private func loadImageFromURL() -> Image {
        if let url = URL(string: imageURL),
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "photo")
        }
    }
}

struct NewsPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        NewsPreviewView(title: "News Title", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent a leo id turpis facilisis placerat. Integer ultrices risus et lectus sollicitudin finibus. Vivamus sed interdum odio. Donec congue auctor sapien at lobortis. Pellentesque consectetur odio ac bibendum consequat. Maecenas sagittis mauris et aliquam cursus. Nam mattis euismod metus, in facilisis justo gravida et. Sed feugiat auctor nisl, ac rhoncus libero consectetur ut. Sed sed lacus eu enim lobortis faucibus. Mauris sed faucibus metus, ac eleifend ex. Cras in suscipit magna, sit amet interdum elit. Quisque viverra mi eu ante blandit feugiat. Sed id elit nec purus ultrices efficitur.", imageURL: "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")
    }
}
