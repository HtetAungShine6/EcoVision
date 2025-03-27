import SwiftUI

struct ArticlesListView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(mockArticles, id: \.self) { article in
                    Button(action: {
                        navigationManager.navigateTo(Destination.articleDetailView(article: article))
                    }) {
                        ArticleCardView(article: article)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Articles")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        })
    }
}

struct ArticleCardView: View {
    let article: Article

    var body: some View {
        HStack(spacing: 12) {
            Image(article.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(article.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(article.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .frame(maxHeight: 80, alignment: .top)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}
