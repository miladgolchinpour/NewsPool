//
//  ArticleImageView.swift
//  ArticleImageView
//
//  Created by Milad Golchinpour on 9/18/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

/// Showing article image view
struct ArticleImageView: View {
    var url: String?
    
    var body: some View {
        if let url = url {
            let imageURL = URL(string: url)
            
            AsyncImage(url: imageURL) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.4)
            }
            .cornerRadius(20)
        }
    }
}

struct ArticleImageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImageView()
    }
}
