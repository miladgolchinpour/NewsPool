//
//  Article.swift
//  Article
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import Foundation

struct Article: Codable {
    var source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct Source: Codable {
    var id: String?
    var name: String
}
