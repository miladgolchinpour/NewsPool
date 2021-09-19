//
//  TabBar.swift
//  TabBar
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        TabView {
            NavigationView { Discover(viewModel: viewModel) }
                .tabItem {
                    Label("Discover", systemImage: "globe.americas")
                }
            
            NavigationView { Topics(viewModel: viewModel) }
                .tabItem {
                    Label("Topics", systemImage: "book")
                }
            
            NavigationView { Bookmarks(viewModel: viewModel) }
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark.square")
                }
        }
    }
}
