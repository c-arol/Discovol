//
//  VolunteerMatchClient.swift
//  Discovol
//
//  Created by Carol Zhang on 8/5/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

//incomplete

import Foundation
import SwiftyJSON
import AFNetworking

class VolunteerMatchClient {
    
    var accessToken: String!
    
    //let VolunteerMatchAPIKey = "575e6c77576da716371b142341bec7aa"
   // let apiToContact = "http://www.volunteermatch.org/api/call?action=searchOpportunities"
    
   // Alamofire.request(.GET, apiToContact).validate().responseJSON() {response in
    //switch response.result {
    //case .Success:
    //if let value = response.result.value {
    //let json = JSON(value)
    
    // Do what you need to with JSON here!
    // The rest is all boiler plate code you'll use for API requests
    
    
    //}
    //case .Failure(let error):
    //print(error)
    //}
    //}
    
    func searchWithTerm(term: String, parameters: Dictionary<String, String>? = nil, offset: Int = 0, limit: Int = 20, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        var params: NSMutableDictionary = [
            "term": term,
            "offset": offset,
            "limit": limit
        ]
        for (key, value) in parameters! {
            params.setValue(value, forKey: key)
        }
        return self.GET("search", parameters: params, success: success, failure: failure)
    }
    
}