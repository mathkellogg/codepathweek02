//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func styleNavBar(nav:UINavigationBar, item: UINavigationItem){
    nav.barTintColor = UIColorFromRGB(0xC41200)
    nav.barStyle = UIBarStyle.Black
    //let logo = UIImageView(image: UIImage(named: "yelplogo"))
    //logo.contentMode = .ScaleAspectFit
    //logo.bounds = CGRect(x: 0, y: 0, width: nav.bounds.width - 10, height: nav.bounds.height - 10)
    //item.titleView = logo
}

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    var filters = [String:AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!
    var navSearchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        styleNavBar((self.navigationController?.navigationBar)!, item: navigationItem)
        
        //build search bar
        navSearchBar = UISearchBar()
        navigationItem.titleView = navSearchBar
        navSearchBar?.delegate = self
        
        searchForBusinesses()
        /*
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            // doing this because first load had wrong cell height.
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            self.tableView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
        */
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        navSearchBar?.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        navSearchBar?.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.row = indexPath.row + 1
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchForBusinesses()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        print("hie")
        
        self.filters = filters
        
        self.searchForBusinesses()
    }
    
    func searchForBusinesses() {
        
        //let filters = self.filters ?? ["categories":[], "deals": false, "distance": 1000, "sort": YelpSortMode.BestMatched]
        
        let searchTerm = self.navSearchBar!.text ?? "Restaurant"
        
        let categories = filters["categories"] as? [String]
        
        let deals = filters["deals"] as? Bool
        
        let distance = filters["distance"] as? Float
        
        let sort = filters["sort_by"] as? YelpSortMode

        print("hwere")
        Business.searchWithTerm(searchTerm, sort: sort, categories: categories, deals: deals, distance: distance){ (businesses: [Business]!, error: NSError!) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            self.tableView.layoutIfNeeded()
            self.tableView.reloadData()
        }
    }
    

}
