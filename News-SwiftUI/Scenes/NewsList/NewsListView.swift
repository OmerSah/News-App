//
//  NewsListView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject var viewModel: NewsListViewModel
    
    @State private var searchText = ""
    
    @State private var showFilter = false
    
    @State private var showSafari = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                if viewModel.news.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                else {
                    List {
                        ForEach(viewModel.news) { article in
                            Button {
                                showSafari = true
                            } label: {
                                NewsListCell(
                                    article: article,
                                    bookmarkSelected: article.isBookmarked
                                ) {
                                    viewModel
                                        .bookmarkButtonAction(
                                            article: article
                                        )
                                }.sheet(isPresented: $showSafari) {
                                    if let url = URL(string: article.url ?? "") {
                                        SafariView(url: url)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.automatic)
                    .searchable(text: $searchText, placement: .toolbar)
                    .onChange(of: searchText) { value in
                        viewModel.fetchNews(
                            query: searchText
                        )
                    }
                    .toolbar {
                        ToolbarItem {
                           FilterButton(
                            showFilter: $showFilter
                           )
                        }
                    }
                }
            }
            .navigationTitle("NEWS_TITLE".localized)
            .onAppear {
                viewModel.onAppear()
            }
            .refreshable {
                viewModel.fetchNews()
            }.sheet(isPresented: $showFilter) {
                FilterView(presenting: $showFilter) { from, to in
                    viewModel.filterNewsByRange(
                        from: from,
                        to: to,
                        query: self.searchText
                    )
                }.offset(y: -200)
            }
        }
        
    }
}

struct FilterButton: View {

    @Binding var showFilter: Bool
    
    var body: some View {
        
        Button {
            showFilter.toggle()
        } label: {
            Image(
                systemName: Constants.UI.filterImage
            )
        }
        
    }
    
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: NewsListViewModel(NewsService(),
                                       BookmarkService()))
    }
}



