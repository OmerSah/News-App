//
//  NewsListCell.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import UIKit
import Kingfisher


class NewsListCell: UITableViewCell {

    private let newsTitleLabel: UILabel = .init(font: UIFont.boldSystemFont(ofSize: 16), lines: 4)
    private let newsDescriptionLabel: UILabel = .init(font: UIFont.systemFont(ofSize: 12), textColor: .lightGray, lines: 5)
    
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: Constants.UI.bookmarkImage), for: .normal)
        button.setImage(UIImage(systemName: Constants.UI.selectedBookmarkImage), for: .selected)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(bookmarkButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var news: Article?
    
    var bookmarkAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        makeAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(newsTitleLabel)
        addSubview(newsImage)
        contentView.addSubview(bookmarkButton)
        addSubview(newsDescriptionLabel)
    }
    
    private func makeAllConstraints() {
        newsImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(8)
            $0.width.height.equalTo(200)
            $0.bottom.equalTo(snp.bottom).offset(-8)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(newsImage.snp.top).offset(8)
            $0.trailing.equalTo(newsImage.snp.trailing).offset(-8)
            $0.size.equalTo(36)
        }
        
        bookmarkButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        newsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(newsImage.snp.trailing).offset(8)
            $0.trailing.equalTo(-8)
        }
        
        newsDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(newsTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(newsImage.snp.trailing).offset(8)
            $0.trailing.equalTo(-8)
            $0.bottom.lessThanOrEqualTo(snp.bottom).offset(-8)
        }
    }
    
    func setArticle(article: Article?) {
        guard let article = article else { return }
        self.news = article
        
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
        
        bookmarkButton.isSelected = article.isBookmarked
        
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: URL(string: article.urlToImage ?? ""))
    }
    
    @objc private func bookmarkButtonAction() {
        bookmarkAction?()
    }
}

