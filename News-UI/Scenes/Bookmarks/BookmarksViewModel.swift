//
//  BookmarksViewModel.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    
    @Published private(set) var news = [Article]()
    
    private let bookmarkService: BookmarkServiceProtocol
    
    init(_ bookmarkService: BookmarkServiceProtocol) {
        self.bookmarkService = bookmarkService
        news = bookmarkService.getBookmarkedNews()
    }
    
    func onAppear() {
        news = bookmarkService.getBookmarkedNews()
    }
}

// MARK: Bookmark Operations
extension BookmarkViewModel {
    
    func deleteBookmarkedArticle(article: Article) {
        var bookmarked: [Article] = bookmarkService.getBookmarkedNews()
        bookmarked = bookmarked.filter( { $0.title != article.title } )
        bookmarkService.setBookmarkedNews(with: bookmarked)
        news = bookmarkService.getBookmarkedNews()
    }
    
}
