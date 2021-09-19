//
//  CountryPickerView.swift
//  CountryPickerView
//
//  Created by Milad Golchinpour on 9/18/21.
//  Copyright © 2021 Milad Golchinpour. All rights reserved.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var viewModel: NewsViewModel
    @Binding var news: News?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(NewsViewModel.countries, id: \.code) { country in
                    HStack {
                        Button {
                            viewModel.country = country
                            news = nil
                            
                            Task {
                                let newNews = await viewModel.fetchNews(customTopic: nil)
                                news = newNews
                            }
                            
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text(country.name)
                        }
                        
                        Spacer()
                        
                        if viewModel.country.code == country.code {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .navigationTitle("Pick Country")
            .toolbar {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(viewModel: NewsViewModel(), news: .constant(News.sample))
    }
}
