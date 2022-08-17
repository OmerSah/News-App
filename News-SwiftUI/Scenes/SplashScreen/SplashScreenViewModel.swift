//
//  SplashScreenViewModel.swift
//  News-SwiftUI
//
//  Created by Ömer Faruk Şahin on 17.08.2022.
//

import Foundation
import UserNotifications
import Combine

class SplashScreenViewModel {
    
    var cancellable: AnyCancellable?
    
    func askNotificationPermission() -> Future<Bool, Error> {
        return Future { promise in
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
              promise(.failure(error))
            } else {
              promise(.success(result))
            }
          }
        }
    }
}
