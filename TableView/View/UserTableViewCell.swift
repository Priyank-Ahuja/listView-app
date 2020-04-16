//
//  UserTableViewCell.swift
//  TableView
//
//  Created by Priyank Ahuja on 16/04/20.
//  Copyright © 2020 Priyank Ahuja. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(user : User) {
        nameLabel.text = "Name: \(user.name ?? "")"
        ageLabel.text = "Age: \(user.age ?? "")"
        locationLabel.text = "Location: \(user.location ?? "")"
        userImageView?.sd_setImage(with: URL(string: "\(user.userImage ?? "")"), placeholderImage: UIImage(named: "userIcon"))
    }
}
