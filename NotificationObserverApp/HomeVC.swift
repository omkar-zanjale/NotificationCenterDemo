//
//  HomeVC.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    lazy var apiNotificationName = NSNotification.Name(apiNotificationKey)
    lazy var favoriteUsersNotificationName = NSNotification.Name(favoriteUsersKey)
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
        NotificationCenter.default.addObserver(self, selector:  #selector(didNotifyAPIResponse), name: apiNotificationName, object: nil)
    }
    
    @objc func didNotifyAPIResponse(notification: NSNotification) {
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Favorite", bundle: nil)
        if let favoriteVC = storyBoard.instantiateViewController(identifier: favoriteVCIdentifier) as? FavoriteVC {
            let favoriteUsers = homeViewModel?.users?.filter({$0.isFavorite==true}) as Any
            let users = ["users": favoriteUsers]
            NotificationCenter.default.post(name: favoriteUsersNotificationName, object: nil, userInfo: users)
            self.navigationController?.pushViewController(favoriteVC, animated: true)
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
                cell.delegate = self
                cell.setUpFavoriteBtn()
                return cell
            }
        }
        return UITableViewCell()
    }
    
}


extension HomeVC: FavoriteTableCellDelegate {
    func didUpdatefavoriteStatus(forUser userId: Int, status: Bool) {
        if let index = homeViewModel?.users?.firstIndex(where: { (user) -> Bool in
            user.id == userId
        }) {
            homeViewModel?.users?[index].isFavorite = status
            self.usersTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
    }
}
