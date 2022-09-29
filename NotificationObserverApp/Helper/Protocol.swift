//
//  Protocol.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import Foundation


protocol FavoriteTableCellDelegate: AnyObject {
    func didUpdatefavoriteStatus(forUser userId: Int, status: Bool)
}
