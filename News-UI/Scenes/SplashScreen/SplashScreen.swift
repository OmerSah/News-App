//
//  SplashScreen.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 15.08.2022.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var openMainScene = false
    @State private var titleOpacity = 0.0
    @State private var title = "Open Main"
    
    private let viewModel = SplashScreenViewModel()
    
    var body: some View {
        if openMainScene {
            TabView {
                NewsListView(viewModel:
                                NewsListViewModel(NewsService(),
                                               BookmarkService()))
                    .tabItem {
                        Image(systemName: Constants.UI.homeImage)
                        Text("HOME".localized)
                    }
                
                BookmarksListView(viewModel:
                                    BookmarkViewModel(
                                        BookmarkService()))
                    .tabItem {
                        Image(systemName: Constants.UI.bookmarkImage)
                        Text("BOOKMARKS_TITLE".localized)
                    }
            }
        }
        else {
            VStack {
                VStack {
                    Text("NEWS_TITLE".localized)
                        .bold()
                        .font(.system(size: 64))
                    
                    Text("by Omer Faruk Sahin")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .frame(width: 164, alignment: .trailing)
                }
                .opacity(titleOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.titleOpacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue
                    .main
                    .asyncAfter(
                        deadline: .now() + 2.0
                    ) {
                        viewModel.cancellable = viewModel.askNotificationPermission()
                            .sink { error in
                                DispatchQueue.main.async {
                                    self.openMainScene = true
                                }
                                print(error)
                            } receiveValue: { permission in
                                DispatchQueue.main.async {
                                    self.openMainScene = true
                                }
                                print("Granted: \(permission)")
                            }
                            
                    }
                
            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
