//
//  ArticleCard.swift
//  ArticleCard
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct ArticleCard: View {
    var article: Article
    
    @Environment(\.colorScheme) var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18.0) {
            HStack {
                Text(article.source.name)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.accentColor)
            }
            
            Text(article.title)
                .multilineTextAlignment(.leading)
            
            VStack(alignment: .leading, spacing: 5.0) {
                ArticleImageView(url: article.urlToImage)
            }
        }
        .foregroundColor(.primary)
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(theme == .dark ? .black : .white)
                .shadow(color: .gray.opacity(0.4), radius: 20, x: 2, y: 5)
        )
    }
}

struct ArticleCard_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCard(article: News.sample.articles[0])
    }
}
