//
//  ArticleCell.swift
//  NYArticle
//
//  Created by Ravi dwivedi on 08/12/19.
//  Copyright © 2019 Ravi dwivedi. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_createdBy:UILabel!
    @IBOutlet weak var lbl_publishedDate:UILabel!
    @IBOutlet weak var  imgView:UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
        imgView.layer.borderWidth = 1.0
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.clipsToBounds = true
    }

}
