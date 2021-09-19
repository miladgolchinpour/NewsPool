//
//  Sidebar.swift
//  Sidebar
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

/// Sidebar for iPad devices
struct Sidebar: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Discover(viewModel: viewModel)) {
                    Label("Discover", systemImage: "globe.americas")
                }
                
                NavigationLink(destination: Topics(viewModel: viewModel)) {
                    Label("Topics", systemImage: "book")
                }
                
                NavigationLink(destination: Bookmarks(viewModel: viewModel)) {
                    Label("Bookmarks", systemImage: "bookmark.square")
                }
            }
            .navigationTitle("News")
            
            // Default view
            Discover(viewModel: viewModel)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(viewModel: NewsViewModel())
    }
}
