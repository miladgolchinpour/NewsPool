//
//  ContentView.swift
//  NewsApp
//
//  Created by Milad Golchinpour on 9/17/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var newsViewModel = NewsViewModel()
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    
    var body: some View {
        if hSizeClass == .compact {
            TabBar(viewModel: newsViewModel)
        } else {
            Sidebar(viewModel: newsViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
