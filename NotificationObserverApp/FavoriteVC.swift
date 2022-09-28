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
    }
    
    private func config() {
        favoritesTable.register(UINib(nibName: "FavoriteTableCell", bundle: nil), forCellReuseIdentifier: favoriteTableCellIdentifier)
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
