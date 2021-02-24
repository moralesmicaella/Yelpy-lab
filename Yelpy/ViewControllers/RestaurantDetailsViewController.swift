//
//  RestaurantDetailsViewController.swift
//  Yelpy
//
//  Created by Micaella Morales on 2/19/21.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = restaurant.name
        ratingImage.image = UIImage(named: Restaurant.getRatingImage(rating: restaurant.rating))
        reviewCountLabel.text = String(restaurant.reviewCount)
        restaurantImage.af.setImage(withURL: restaurant.imageURL)
        priceLabel.text = restaurant.price + " · "
        categoryLabel.text = restaurant.category
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
