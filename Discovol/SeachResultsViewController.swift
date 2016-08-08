//
//  SeachResultsViewController.swift
//  Discovol
//
//  Created by Carol Zhang on 8/3/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import UIKit
import CoreLocation

class SearchResultsViewController: SearchViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    //var activityIndicator: ActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 116
//        self.tableView.addInfiniteScrollingWithActionHandler({
//            self.performSearch(self.searchBar.text, offset: self.offset, limit: self.limit)
//        })
        //self.tableView.showsInfiniteScrolling = false
        self.tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchResultsViewController.onUserLocation), name: "UserLocation/updated", object: nil)
        self.userLocation.requestLocation()
        
        //let activityIndicator = (NSBundle.mainBundle().loadNibNamed("ActivityIndicator", owner: self, options: nil)[0] as! ActivityIndicator)
        //self.activityIndicator = activityIndicator
        //self.tableView.tableFooterView = activityIndicator
    }
    
    func onUserLocation() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UserLocation/updated", object: nil)
        if self.searchBar.text == "" {
            self.performSearch("Volunteer Opportunities")
        }
    }
    
    override func onBeforeSearch() {
        //self.activityIndicator.animate()
    }
    
    override func onResults(results: Array<VolunteerEvent>, total: Int, response: NSDictionary) {
        //self.tableView.infiniteScrollingView.stopAnimating()
        //self.tableView.showsInfiniteScrolling = results.count < total
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.reloadData()
    }
    
    override func onResultsCleared() {
        //self.activityIndicator.stopAnimating()
        //self.tableView.tableFooterView = self.activityIndicator
        //self.tableView.showsInfiniteScrolling = false
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultsTableViewCell")
        let organization = self.results[indexPath.row]
    
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let result = self.results[indexPath.row]
        self.showDetailsForResult(result)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if segue.destinationViewController is UINavigationController {
            let navigationController = segue.destinationViewController as! UINavigationController
            if navigationController.viewControllers[0] is MapViewController {
                let controller = navigationController.viewControllers[0] as! MapViewController
                controller.delegate = self
            }
        }
    }
    

}