//
//  ArticleView.swift
//  ArticleView
//
//  Created by Milad Golchinpour on 9/18/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

/// ArticleView included title, image, description, content, author and publish date
struct ArticleView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var article: Article
    
    var df: DateFormatter = {
        let ft = DateFormatter()
        
        ft.dateFormat = "yyyy-mm-dd"
        ft.dateStyle = .medium
        
        return ft
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 43.0) {
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    ArticleImageView(url: article.urlToImage)
                    
                    if let description = article.description {
                        Text(description)
                    }
                }
                
                if let content = article.content {
                    // Content text with Lora font
                    Text(content)
                        .font(.custom("Lora", size: 20))
                }
                
                let url = URL(string: article.url)!
                Link("View full article", destination: url)
                    .font(.headline)
                    .padding(.bottom)
                    .foregroundColor(.blue)
                
                HStack {
                    Text(article.author ?? "Unknown")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    let date = df.date(from: article.publishedAt) ?? Date()
                    Text(df.string(from: date))
                }
                .padding(10)
                .background(Color.blue.opacity(0.2).cornerRadius(5))
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle(article.source.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.toggleArticleBookmark(article: article)
            } label: {
                Image(systemName: viewModel.articleIsBookmark(article) ? "bookmark.fill" : "bookmark")
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(viewModel: NewsViewModel(), article: News.sample.articles[0])
    }
}
