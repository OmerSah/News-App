//
//  NewsListViewModel.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import Foundation

class NewsListViewModel: ObservableObject {
    
    @Published private(set) var news = [Article]()
    
    private let newsService: NewsServiceProtocol
    private let bookmarkService: BookmarkServiceProtocol
    
    // Common handler for different operations
    private lazy var completion: (Result<NewsResponse,NetworkError>) -> () =
    { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            DispatchQueue.main.async {
                guard !response.articles.isEmpty else { return }
                self.news = response.articles
                self.news = self.bookmarkService.updateBookmarkedNews(in: self.news)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
    init(_ newsService: NewsServiceProtocol,
         _ bookmarkService: BookmarkServiceProtocol) {
        
        self.bookmarkService = bookmarkService
        self.newsService = newsService
    
        fetchNews()
        news = bookmarkService.updateBookmarkedNews(in: news)
    }
    
    
    func onAppear() {
        fetchNews()
        news = bookmarkService.updateBookmarkedNews(in: news)
    }
    
}

// MARK: Network Operatioons
extension NewsListViewModel {
    
    func fetchNews(query: String = "") {
        guard query != "" else {
            newsService.fetchTopHeadlines(1, completion: completion)
            return
        }
        newsService.fetchSearchData(query, 1, "", "", completion: completion)
    }
    
    func filterNewsByRange(from: String, to: String, query: String) {
                
        guard query == "" else {
            newsService.fetchSearchData(query, 1, from, to, completion: completion)
            return
        }
        newsService.fetchNewsOfSpecifiedDates(1, from, to, completion: completion)
    }
    
}

// MARK: Bookmark Operatioons
extension NewsListViewModel {
    
    func bookmarkButtonAction(article: Article) {
        var bookmarked = bookmarkService.getBookmarkedNews()
        
        if !article.isBookmarked  {
            bookmarked.append(article)
        } else {
            bookmarked = bookmarked.filter( { $0.title != article.title } )
        }
        
        bookmarkService.setBookmarkedNews(with: bookmarked)
        news = bookmarkService.updateBookmarkedNews(in: news)
    }
    
}
