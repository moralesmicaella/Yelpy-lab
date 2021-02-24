//
//  RestaurantCell.swift
//  Yelpy
//
//  Created by Micaella Morales on 2/18/21.
//

import UIKit
import AlamofireImage

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var restaurantImage: UIImageView!

    var restaurant: Restaurant! {
        didSet {
            nameLabel.text = restaurant.name
            categoryLabel.text = restaurant.category
            phoneNumLabel.text = restaurant.phoneNum
            reviewCountLabel.text = String(restaurant.reviewCount)
            ratingImage.image = UIImage(named: Restaurant.getRatingImage(rating: restaurant.rating))
            restaurantImage.af.setImage(withURL: restaurant.imageURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
