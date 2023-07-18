//
//  UsersTableViewCellStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 18/07/23.
//

import UIKit

class UsersTableViewCellStoryboard: UITableViewCell {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
