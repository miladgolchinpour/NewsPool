//
//  News.swift
//  News
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

extension News {
    static var sample: News {
        let url = Bundle.main.url(forResource: "sampleNews", withExtension: "json")!
        let data = try? Data(contentsOf: url)
        let decoded = try? JSONDecoder().decode(News.self, from: data!)
        return decoded!
    }
}
