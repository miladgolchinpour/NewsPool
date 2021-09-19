//
//  Topics.swift
//  Topics
//
//  Created by Milad Golchinpour on 9/19/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct Topics: View {
    @ObservedObject var viewModel: NewsViewModel
    
    @State private var search = ""
    @State private var customTopic = ""
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    
    var body: some View {
        if hSizeClass == .compact {
            content.listStyle(.sidebar)
        } else {
            content.listStyle(.insetGrouped)
        }
    }
    
    @ViewBuilder
    var content: some View {
        let filteredTopics: [String] = {
            if search.isEmpty {
                return NewsViewModel.topics
            }
            
            return NewsViewModel.topics.filter { $0.contains(search.capitalized) }
        }()
        
        List {
            NavigationLink {
                TopicResultView(viewModel: viewModel, topic: customTopic)
            } label: {
                TextField("Enter custom keyword...", text: $customTopic)
            }
            
            ForEach(filteredTopics, id: \.self) { topic in
                NavigationLink {
                    TopicResultView(viewModel: viewModel, topic: topic)
                } label: {
                    HStack {
                        LetterImage(letter: topic.first!)
                        
                        Text(topic)
                    }
                }
            }
        }
        .navigationTitle("Topics")
        .searchable(text: $search)
    }
}

struct Topics_Previews: PreviewProvider {
    static var previews: some View {
        Topics(viewModel: NewsViewModel())
    }
}
