//
//  FavoriteTableCell.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import UIKit

class FavoriteTableCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            self.lblName.text = "Name : " + (user.name ?? "")
            self.lblEmail.text = "Email : " + (user.email ?? "")
            self.lblPhone.text = "Phone : " + (user.phone ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func removeFavoriteBtnAction(_ sender: Any) {
        let favoriteUpdateNotificationName = NSNotification.Name(updateFavoriteUserNotifyKey)
        let userInfo: [String: Any] = [
            "userId": user?.id as Any,
            "favoriteStatus": false
        ]
        NotificationCenter.default.post(name: favoriteUpdateNotificationName, object: nil, userInfo: userInfo)
    }
}
