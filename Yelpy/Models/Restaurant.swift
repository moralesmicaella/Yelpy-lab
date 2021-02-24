//
//  Restaurant.swift
//  Yelpy
//
//  Created by Micaella Morales on 2/19/21.
//

import Foundation

class Restaurant {
    
    var name: String
    var category: String
    var phoneNum: String
    var reviewCount: Int
    var rating: Float
    var imageURL: URL
    var price: String
    
    init(dict: [String: Any]) {
        name = dict["name"] as! String
        phoneNum = dict["display_phone"] as! String
        reviewCount = dict["review_count"] as! Int
        rating = dict["rating"] as! Float
        imageURL = URL(string: dict["image_url"] as! String)!
        category = Restaurant.getCategoryList(dict: dict)
        price = dict["price"] as? String ?? ""
    }
    
    static func getCategoryList(dict: [String: Any]) -> String {
        var categoryList = ""
        let categories = dict["categories"] as? [[String: Any]] ?? [[:]]
        
        for index in 0...(categories.count - 1) {
            let category = categories[index]
            categoryList += category["title"] as! String
            if index != (categories.count - 1) {
                categoryList += ", "
            }
        }
        return categoryList
    }
    
    static func getRatingImage(rating: Float) -> String {
        switch rating {
            case 1.0:
                return "regular_1"
            case 1.5:
                return "regular_1_half"
            case 2.0:
                return "regular_2"
            case 2.5:
                return "regular_2_half"
            case 3.0:
                return "regular_3"
            case 3.5:
                return "regular_3_half"
            case 4.0:
                return "regular_4"
            case 4.5:
                return "regular_4_half"
            case 5.0:
                return "regular_5"
            default:
                return "regular_0"
        }
    }
    
}
