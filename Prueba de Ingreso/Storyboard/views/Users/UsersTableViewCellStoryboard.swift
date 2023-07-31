//
//  UsersTableViewCellStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 18/07/23.
//

import UIKit

class UserTableViewCellViewModelStoryboard {
    var user: User
    init(user: User) {
        self.user = user
    }
}

class UsersTableViewCellStoryboard: UITableViewCell {

    var viewModel = TableViewCellViewModel()
    var cellTapped: ((User) -> Void)?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentStack: UIStackView!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var phoneImg: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailImg: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var postsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: User){
        self.viewModel.user = item
        nameLabel.text = item.name
        nameLabel.textColor = .primary
        phoneLabel.text = item.phone
        phoneImg.image = .init(systemName: "phone.fill")
        emailLabel.text = item.email
        emailImg.image = .init(systemName: "mail.fill")
        emptyLabel.text = ""
    }
    
    @IBAction func postsButtonPressed(_ sender: Any){
        print(self.viewModel.user!.id)
        if let user = self.viewModel.user{
            Networking.urlPost = "/posts?userId=\(user.id)"
            self.cellTapped?(user)
        }
    }
}

