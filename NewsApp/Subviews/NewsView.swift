//
//  NewsView.swift
//  NewsView
//
//  Created by Milad Golchinpour on 9/19/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

/// Show articles in a list with article cards
struct NewsView: View {
    var news: News?
    @State private var isShowError = false
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        ScrollView {
            if let news = news {
                if news.articles.isEmpty {
                    Text("No Result")
                        .font(.headline)
                } else {
                    ForEach(news.articles, id: \.publishedAt) { article in
                        NavigationLink {
                            ArticleView(viewModel: viewModel, article: article)
                        } label: {
                            ArticleCard(article: article)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                    }
                }
            } else if isShowError {
                Text("No Result")
                    .padding()
                    .font(.headline)
            } else {
                ProgressView()
            }
        }
        .task {
            /// Stop getting articles after 15 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                if news == nil { isShowError = true }
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(news: News.sample, viewModel: NewsViewModel())
    }
}
