//
//  Bookmarks.swift
//  Bookmarks
//
//  Created by Milad Golchinpour on 9/18/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct Bookmarks: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        if viewModel.bookmarks.isEmpty {
            Text("No Bookmark")
                .font(.headline)
        } else {
            ScrollView {
                ForEach(viewModel.bookmarks, id: \.publishedAt) { article in
                    NavigationLink {
                        ArticleView(viewModel: viewModel, article: article)
                    } label: {
                        ArticleCard(article: article)
                            .padding()
                    }
                }
            }
            .navigationTitle("Bookmarks")
        }
    }
}

struct Bookmarks_Previews: PreviewProvider {
    static var previews: some View {
        Bookmarks(viewModel: NewsViewModel())
    }
}
