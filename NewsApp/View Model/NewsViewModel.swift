//
//  NewsViewModel.swift
//  NewsViewModel
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import Foundation

/// Access to all properties and methods for getting data
@MainActor
class NewsViewModel: ObservableObject {
    /// Saved bookmarks to userDefaults
    @Published private(set) var bookmarks: [Article] {
        didSet {
            if let encoded = try? JSONEncoder().encode(bookmarks) {
                UserDefaults.standard.setValue(encoded, forKey: "bookmarks")
            }
        }
    }
    
    init() {
        let ud = UserDefaults.standard
        
        // Assign all encoded data in ud to the properties
        if let data = ud.data(forKey: "bookmarks"), let data1 = ud.data(forKey: "country") {
            if let decoded = try? JSONDecoder().decode([Article].self, from: data), let decoded1 = try? JSONDecoder().decode(Country.self, from: data1) {
                self.bookmarks = decoded
                self.country = decoded1
                return
            }
        }
        
        self.bookmarks = []
        
        // Default country is United States
        self.country = Country(name: "United States", code: "us")
    }
    
    /// Country Model
    struct Country: Codable {
        var name: String
        var code: String
    }
    
    /// Country List
    static var countries: [Country] {
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")!
        let data = try? Data(contentsOf: url)
        let decoded = try? JSONDecoder().decode([Country].self, from: data!)
        return decoded!
    }
    
    /// Selected Country by user
    @Published var country: Country {
        didSet {
            if let encoded = try? JSONEncoder().encode(country) {
                UserDefaults.standard.setValue(encoded, forKey: "country")
            }
        }
    }
    
    /// Some topic list
    static var topics = ["Apple", "Technology", "Bitcoin", "Celebrities", "Business", "COVID-19", "Politicis", "Fashion", "Sports", "Entertainment", "Travel", "Science"]
    
    /// Get all hottest news or by topic
    func fetchNews(customTopic: String?) async -> News? {
        let topic = (customTopic ?? "").isEmpty ? "Today" : customTopic ?? ""
        
        let urlTopheadlines = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country.code)")!
        let urlEverything = URL(string: "https://newsapi.org/v2/everything?q=\(topic)")!
        
        var request = URLRequest(url: customTopic != nil ? urlEverything : urlTopheadlines)
        request.httpMethod = "GET"
        request.addValue("4e5f8cc1000048828d90469cabe1d277", forHTTPHeaderField: "X-Api-Key")
        
        print(request.url!.description)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(News.self, from: data)
            return decoded
        } catch {
            print("Error in fetch news")
        }
        
        return nil
    }
    
    /// Toggle article bookmark
    func toggleArticleBookmark(article: Article) {
        if articleIsBookmark(article) {
            bookmarks.removeAll { $0.title == article.title }
        } else {
            bookmarks.append(article)
        }
    }
    
    /// If the article was in bookmark list result is true
    func articleIsBookmark(_ article: Article) -> Bool {
        if bookmarks.contains(where: { $0.title == article.title}) {
            return true
        }
        
        return false
    }
}
