//
//  HomeViewModel.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import Foundation

class HomeViewModel {
    
    var users: [User]?
    
    func getUsers() {
        NetworkManager.getAPI(url: "https://jsonplaceholder.typicode.com/users", resultType: [User].self) { [weak self] result in
            self?.users = result
            let notificationName = NSNotification.Name(apiCompleteNotifyKey)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }
}
