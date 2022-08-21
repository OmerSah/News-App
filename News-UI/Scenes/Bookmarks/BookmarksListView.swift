//
//  BookmarksListView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

struct BookmarksListView: View {
    
    @StateObject var viewModel: BookmarkViewModel
    
    @StateObject var selectedState = SelectedState()
    
    @State private var showSafari = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.news) { article in
                    Button {
                        showSafari = true
                        selectedState.article = article
                    } label: {
                        BookmarksListCell(
                            article: article
                        )
                    }.tint(.black)
                }
                .onDelete { indexSet in
                    guard let index = indexSet.first
                    else {
                        return
                    }
                    viewModel.deleteBookmarkedArticle(article: viewModel.news[index])
                }
            }
            .navigationTitle("BOOKMARKS_TITLE".localized)
            .onAppear {
                viewModel.onAppear()
            }
            .sheet(isPresented: $showSafari) {
                if  let selectedArticle = selectedState.article,
                    let url = URL(string: selectedArticle.url ?? "") {
                    SafariView(url: url)
                }
            }
        }
        
    }
}

struct BookmarksListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksListView(viewModel:
                            BookmarkViewModel(
                                BookmarkService()
                            ))
    }
}
