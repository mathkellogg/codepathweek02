//
//  ExpandableCellTableViewCell.swift
//  Yelp
//
//  Created by Mathew Kellogg on 9/24/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

enum cellState {
    case Selected, Unselected, Selecting
}

class ExpandableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cueImage: UIImageView!

    var state: cellState = .Unselected {
        didSet {
            var img: UIImage
            print("State: \(state)")
            switch state {
            case .Selected:
            img = UIImage(named: "circleCheck")!
            case .Unselected:
            img = UIImage(named: "downPointer")!
            case .Selecting:
            img = UIImage(named: "circleUncheck")!
            default: break
            }
            cueImage.image = img
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            state = .Selected
        }
    }

}
