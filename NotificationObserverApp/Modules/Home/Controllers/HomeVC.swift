//
//  HomeVC.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    @IBOutlet weak var usersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        homeViewModel = HomeViewModel()
        createObservers()
        homeViewModel?.getUsers()
        usersTable.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: userTableCellIdentifier)
    }
    
    func createObservers() {
        let apiNotificationName = NSNotification.Name(apiCompleteNotifyKey)
        let favoriteStatusNotificationName = NSNotification.Name(updateFavoriteUserNotifyKey)
        NotificationCenter.default.addObserver(self, selector:  #selector(didNotifyAPIResponse), name: apiNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didNotifyUpdateFavoriteStatus), name: favoriteStatusNotificationName, object: nil)
    }
    
    @objc func didNotifyUpdateFavoriteStatus(notification: NSNotification) {
        guard let userId = notification.userInfo?["userId"] as? Int, let status = notification.userInfo?["favoriteStatus"] as? Bool else {return}
        if let index = homeViewModel?.users?.firstIndex(where: { (user) -> Bool in
            user.id == userId
        }) {
            homeViewModel?.users?[index].isFavorite = status
            self.usersTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
    
    
    @objc func didNotifyAPIResponse(notification: NSNotification) {
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Favorite", bundle: nil)
        let favoriteUsersNotificationName = NSNotification.Name(favoriteUsersNotifyKey)
        if let favoriteVC = storyBoard.instantiateViewController(identifier: favoriteVCIdentifier) as? FavoriteVC {
            guard let favoriteUsers = homeViewModel?.users?.filter({$0.isFavorite==true}) else { return }
            if !(favoriteUsers.isEmpty) {
                let users = ["users": favoriteUsers]
                NotificationCenter.default.post(name: favoriteUsersNotificationName, object: nil, userInfo: users)
                self.navigationController?.pushViewController(favoriteVC, animated: true)
            } else {
                showAlert(title: "Warning", message: "Favorite is empty!")
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = usersTable.dequeueReusableCell(withIdentifier: userTableCellIdentifier, for: indexPath) as? UserTableCell {
            if let user = homeViewModel?.users?[indexPath.row] {
                cell.user = user
                cell.setUpFavoriteBtn()
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
