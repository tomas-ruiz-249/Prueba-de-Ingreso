//
//  PostsTableViewCellStoryboard.swift
//  Prueba de Ingreso
//
//  Created by Ronald Ivan Ruiz Poveda on 24/07/23.
//

import UIKit


class PostsTableViewCellStoryboard: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: Post){
        titleLabel.text = item.title
        postLabel.text = item.body
    }
}
