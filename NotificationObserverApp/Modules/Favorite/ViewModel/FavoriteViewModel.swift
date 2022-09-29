//
//  FavoriteViewModel.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import Foundation

class FavoriteViewModel {
    
    var users: [User]?
    
    init() {
        createObserver()
    }
    
    private func createObserver() {
        let favoriteNotificationName = NSNotification.Name(favoriteUsersNotifyKey)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyFavoriteUser(notification:)), name: favoriteNotificationName, object: nil)
    }
    
    @objc
    func notifyFavoriteUser(notification: NSNotification) {
        if let users = notification.userInfo?["users"] as? [User] {
            self.users = users
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
