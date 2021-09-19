//
//  TopicResultView.swift
//  TopicResultView
//
//  Created by Milad Golchinpour on 9/19/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

/// Result of selected or custom topic by user
struct TopicResultView: View {
    @ObservedObject var viewModel: NewsViewModel
    var topic: String
    
    @State private var news: News?
    
    var body: some View {
        NewsView(news: news, viewModel: viewModel)
            .task {
                await news = viewModel.fetchNews(customTopic: topic)
            }
            .refreshable {
                await news = viewModel.fetchNews(customTopic: topic)
            }
            .navigationTitle("\(topic) News")
    }
}

struct TopicResultView_Previews: PreviewProvider {
    static var previews: some View {
        TopicResultView(viewModel: NewsViewModel(), topic: "Apple")
    }
}
