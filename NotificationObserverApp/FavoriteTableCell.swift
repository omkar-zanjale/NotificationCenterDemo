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
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            self.lblName.text = "Name : " + (user.name ?? "")
            self.lblEmail.text = "Email : " + (user.email ?? "")
            self.lblPhone.text = "Phone : " + (user.phone ?? "")
        }
    }

}
