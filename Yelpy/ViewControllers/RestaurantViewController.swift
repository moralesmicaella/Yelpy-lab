//
//  RestaurantViewController.swift
//  Yelpy
//
//  Created by Micaella Morales on 2/18/21.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class RestaurantViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, SkeletonTableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var restaurants = [Restaurant]()
    var filteredRestaurants = [Restaurant]()
    var animationView: AnimationView?
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
        getRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        startAnimation()
    }
    
    func startAnimation() {
        tableView.showAnimatedGradientSkeleton()
        animationView = .init(name: "35625-food-choose")
        animationView?.frame = CGRect(x: 0, y: view.frame.height / 2 - view.frame.width / 2, width: view.frame.width, height: view.frame.width)
        animationView?.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 5
        animationView?.play()
    }
    
    func stopAnimation() {
        animationView?.stop()
        tableView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        
        view.subviews.last?.removeFromSuperview()
    }
    
    // Get data from API helper and retrieve restaurants
    func getRestaurants() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurants = restaurants
            self.filteredRestaurants = restaurants
            self.stopAnimation()
            self.tableView.reloadData()
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestaurantCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredRestaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = filteredRestaurants[indexPath.row]
        cell.restaurant = restaurant
        
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredRestaurants = searchText.isEmpty ? restaurants : restaurants.filter({ (Restaurant) -> Bool in
            let name = Restaurant.name
            return name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        tableView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredRestaurants = restaurants
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let restaurant = filteredRestaurants[indexPath.row]

        let detailsViewController = segue.destination as! RestaurantDetailsViewController
        detailsViewController.restaurant = restaurant
    }
    

}
