//
//  BookmarksListCell.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI
import Kingfisher

struct BookmarksListCell: View {
    
    let article: Article
    
    var body: some View {

        HStack {
            ZStack {
                KFImage.url(URL(
                    string: article.urlToImage ?? ""
                ))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 164, height: 164, alignment: .center)
                    .clipped()
                    .cornerRadius(15)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(self.article.title)
                    .bold()
                    .font(.system(size: 16))
                    .lineLimit(4)
                
                Text(self.article.url ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .lineLimit(5)
            }
            
            Spacer()
        }
        
    }
}

struct BookmarksListCell_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksListCell(article: dummyArticle)
    }
}
