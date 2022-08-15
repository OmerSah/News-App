//
//  BookmarksListView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

struct BookmarksListView: View {
    
    @StateObject var viewModel: BookmarkViewModel
    
    @State private var showSafari = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.news) { article in
                    Button {
                        showSafari = true
                    } label: {
                        BookmarksListCell(
                            article: article
                        )
                        .sheet(isPresented: $showSafari) {
                            if let url = URL(string: article.url ?? "") {
                                SafariView(url: url)
                            }
                        }
                    }.tint(.black)
                    
                }.onDelete { indexSet in
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
