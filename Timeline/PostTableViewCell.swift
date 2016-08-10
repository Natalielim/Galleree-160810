//
//  PostTableViewCell.swift
//  Galleree
//
//  Created by Natalie Lim on 7/28/16.
//  Copyright © 2016 Dianatalie. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithPost(post: Post) {
        
        postImageView.image = post.photo
    }
}