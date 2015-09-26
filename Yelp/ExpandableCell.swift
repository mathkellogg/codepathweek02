//
//  ExpandableCellTableViewCell.swift
//  Yelp
//
//  Created by Mathew Kellogg on 9/24/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class ExpandableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cueImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
