//
//  ArticleDetailView.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 24/2/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(article.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                
                Text(article.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(article.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text(article.paragraph)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Article")
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
    }
}
