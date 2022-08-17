//
//  NewsListView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

class SelectedState: ObservableObject {
    @Published var article: Article?
}

struct NewsListView: View {
    
    @StateObject var viewModel: NewsListViewModel
    
    @StateObject var selectedState = SelectedState()
    
    @State private var searchText = ""
    
    @State private var showFilter = false
    
    @State private var showSafari = false
    
    @State private var fromDate = Date()
    
    private let minimumDate: Date = DateFormatter.filterDateFormat.date(from: "2022-07-20")!
    private let maximumDate: Date = DateFormatter.filterDateFormat.date(from: "2022-08-15")!
    
    @State private var toDate = Date()
    var body: some View {
        NavigationView {
            List(viewModel.news) {  article in
                Button {
                    showSafari = true
                    selectedState.article = article
                } label: {
                    NewsListCell(
                        article: article,
                        bookmarkSelected: article.isBookmarked
                    ) {
                        viewModel.bookmarkButtonAction(
                                article: article
                        )
                    }
                }
            }
            .listStyle(DefaultListStyle())
            .navigationTitle("NEWS_TITLE".localized)
            .searchable(text: $searchText, placement: .toolbar)
            .onChange(of: searchText) { value in
                viewModel.fetchNews(
                    query: searchText
                )
            }
            .refreshable {
                viewModel.fetchNews()
            }
            .toolbar {
                ToolbarItem {
                    FilterButton(
                        showFilter: $showFilter
                    )
                }
            }
            .onAppear(perform: {
                viewModel.fetchNews(query: searchText)
            })
            .overlay {
                if viewModel.news.isEmpty {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .sheet(isPresented: $showSafari) {
                if let selectedArticle = selectedState.article,
                   let url = URL(
                    string: selectedArticle.url ?? ""
                ) {
                    SafariView(url: url)
                }
            }
            .sheet(isPresented: $showFilter) {
                FilterView(presenting: $showFilter) { from, to in
                    viewModel.filterNewsByRange(
                        from: from,
                        to: to,
                        query: self.searchText
                    )
                }.offset(y: UIScreen.main.bounds.height * -0.2)
            }
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



