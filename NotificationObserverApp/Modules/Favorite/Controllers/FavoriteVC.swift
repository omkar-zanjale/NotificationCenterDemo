//
//  FavoriteVC.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var favoritesTable: UITableView!
    let favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        createObserver()
    }
    
    private func createObserver() {
        let updateFavoriteNotificationName = NSNotification.Name(updateFavoriteUserNotifyKey)
        NotificationCenter.default.addObserver(self, selector: #selector(didNotifyUpdateFavorite(notification:)), name: updateFavoriteNotificationName, object: nil)
    }
    
    @objc private func didNotifyUpdateFavorite(notification: NSNotification) {
        guard let userId = notification.userInfo?["userId"] as? Int else {return}
        if let index = favoriteViewModel.users?.firstIndex(where: {$0.id == userId}) {
            self.favoriteViewModel.users?.remove(at: index)
            self.favoritesTable.reloadData()
        }
    }
    
    private func config() {
        self.title = "Favorite"
        favoritesTable.register(UINib(nibName: "FavoriteTableCell", bundle: nil), forCellReuseIdentifier: favoriteTableCellIdentifier)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FavoriteVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteViewModel.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = favoritesTable.dequeueReusableCell(withIdentifier: favoriteTableCellIdentifier) as? FavoriteTableCell {
            cell.user = favoriteViewModel.users?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
