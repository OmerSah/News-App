//
//  ContentView.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI
import Kingfisher

struct NewsListCell: View {
    
    let article: Article
    
    @State var bookmarkSelected: Bool
    
    var bookmarkButtonAction: (() -> Void)?
    
    var body: some View {
        
        HStack {
            ZStack {
                KFImage(URL(
                    string: article.urlToImage ?? ""
                ))
                .placeholder {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 164, height: 164, alignment: .center)
                .clipped()
                .cornerRadius(16)
                
                Button {
                    bookmarkSelected.toggle()
                    bookmarkButtonAction?()
                } label: {
                    Image(
                        systemName:
                            bookmarkSelected ?
                            Constants.UI.selectedBookmarkImage :
                            Constants.UI.bookmarkImage
                    )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12)
                }
                .frame(width: 32, height: 32)
                .background(Color.white)
                .clipShape(Circle())
                .offset(x: 52, y: -52)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(self.article.title)
                    .bold()
                    .font(.system(size: 16))
                    .lineLimit(4)
                
                
                Text(self.article.description ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .lineLimit(5)
            }
            
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListCell(article: dummyArticle, bookmarkSelected: false)
    }
}
