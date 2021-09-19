//
//  Discover.swift
//  Discover
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct Discover: View {
    @ObservedObject var viewModel: NewsViewModel
    @State private var news: News?
    @State private var isShowCountrySelector = false
    
    var body: some View {
        NewsView(news: news, viewModel: viewModel)
            .task {
                news = await viewModel.fetchNews(customTopic: nil)
            }
            .refreshable {
                news = await viewModel.fetchNews(customTopic: nil)
            }
            .navigationTitle("Discover")
            .toolbar {
                if news != nil {
                    Button {
                        isShowCountrySelector.toggle()
                    } label: {
                        Image(systemName: "flag")
                    }
                }
            }
            .sheet(isPresented: $isShowCountrySelector) {
                CountryPickerView(viewModel: viewModel, news: $news)
            }
    }
}

struct Discover_Previews: PreviewProvider {
    static var previews: some View {
        Discover(viewModel: NewsViewModel())
    }
}
