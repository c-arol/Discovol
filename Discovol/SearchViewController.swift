//
//  SearchViewController.swift
//  Discovol
//
//  Created by Carol Zhang on 8/3/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class SearchViewController: UIViewController, UISearchBarDelegate { //CauseFilterViewDelegate {
    
    var searchBar: UISearchBar!
    
    var client: VolunteerMatchClient!
    
    var userLocation: UserLocation!
    
    var results: Array<VolunteerEvent> = []
    var offset: Int = 0
    var total: Int!
    let limit: Int = 20
    var lastResponse: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.client = VolunteerMatchClient
        
        self.userLocation = UserLocation()
        
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        self.searchBar.placeholder = "e.g. New York, San Francisco"
        self.navigationItem.titleView = self.searchBar
    }
    
    final func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.clearResults()
        self.performSearch(searchBar.text!)
    }
    
    final func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.clearResults()
        }
    }
    
    final func performSearch(term: String, offset: Int = 0, limit: Int = 20) {
        self.searchBar.text = term
        self.searchBar.resignFirstResponder()
        self.onBeforeSearch()
        self.client.searchWithTerm(term, parameters: self.getSearchParameters(), offset: offset, limit: 30, success: {
       //     (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let results = (response["events"] as Array).map({
                (business: NSDictionary) -> VolunteerEvent in
                return VolunteerEvent(dictionary: opportunity)
            })
            
            self.results += results
            self.total = response["total"] as Int
            self.lastResponse = response as NSDictionary
            self.offset = self.results.count
            self.onResults(self.results, total: self.total, response: self.lastResponse)
            }, failure: {
         //       (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
             //   println(error)
        })
    }
    
    func getSearchParameters() -> Dictionary<String, String> {
        var parameters = [
            "ll": "\(userLocation.latitude),\(userLocation.longitude)"
        ]
        for (key, value) in VolunteerMatchCategories.instance.parameters {
            parameters[key] = value
        }
        return parameters
    }
    
    func onBeforeSearch() -> Void {}
    
    func onResults(results: Array<VolunteerEvent>, total: Int, response: NSDictionary) -> Void {}
    
    final func clearResults() {
        self.results = []
        self.offset = 0
        self.onResultsCleared()
    }
    
    func onResultsCleared() -> Void {}
    
    func showDetailsForResult(result: VolunteerEvent) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller = storyboard.instantiateViewControllerWithIdentifier("Details") as! EventDetailsViewController
        controller.event = result
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is UINavigationController {
            let navigationController = segue.destinationViewController as! UINavigationController
            if navigationController.viewControllers[0] is CauseFilterViewController {
                let controller = navigationController.viewControllers[0] as! CauseFilterViewController
                controller.delegate = self
            } else if (navigationController.viewControllers[0] is EventDetailsViewController) {
                let controller = navigationController.viewControllers[0] as! EventDetailsViewController
                
            }
        }
    }
    
    final func onFiltersDone(controller: CauseFilterViewController) {
        if self.searchBar.text != "" {
            self.clearResults();
            self.performSearch(self.searchBar.text!)
        }
    }
    
    func synchronize(searchView: SearchViewController) {
        self.searchBar.text = searchView.searchBar.text
        self.results = searchView.results
        self.total = searchView.total
        self.offset = searchView.offset
        self.lastResponse = searchView.lastResponse
        
        if self.results.count > 0 {
            self.onResults(self.results, total: self.total, response: self.lastResponse)
        } else {
            self.onResultsCleared()
        }
    }
    
}

