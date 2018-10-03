//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Hemanth Kasoju on 2018-09-28.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit

// This class consists of references to the contents such as UIViewimage, label, text field present in each cell of the table
class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    //This is the reference for meal name in each cell of the table
    @IBOutlet weak var nameLabel: UILabel!
    
    // This is a reference to the image of the meal in the cell
    @IBOutlet weak var photoImageView: UIImageView!
    
    // This is a reference to the rating of the meal
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
