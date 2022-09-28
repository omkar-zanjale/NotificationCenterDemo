//
//  UserTableCell.swift
//  NotificationObserverApp
//
//  Created by TTPL on 28/09/22.
//

import UIKit



class UserTableCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    private var isFavorite: Bool?
    weak var delegate: FavoriteTableCellDelegate?
    var user: User? {
        didSet {
            guard let user = user else { return }
            self.lblName.text = "Name : " + (user.name ?? "")
            self.lblEmail.text = "Email : " + (user.email ?? "")
            self.isFavorite = user.isFavorite ?? false
        }
    }
    
    func setUpFavoriteBtn() {
        if isFavorite ?? false {
            btnFavorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            btnFavorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func favoriteBtnAction(_ sender: Any) {
        let favoriteStatus = !(isFavorite ?? false)
        delegate?.didUpdatefavoriteStatus(forUser: (user?.id ?? 0), status: favoriteStatus)
    }
}
