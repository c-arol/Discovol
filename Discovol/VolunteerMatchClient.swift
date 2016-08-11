//
//  VolunteerMatchClient.swift
//  Discovol
//
//  Created by Carol Zhang on 8/5/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class VolunteerMatchClient {
    
    static func parseJSON() {
        
        var accessToken: String!
        
        let VolunteerMatchAPIKey = "575e6c77576da716371b142341bec7aa"
        let apiToContact = "http://www.volunteermatch.org/api/call?action=searchOpportunities"
        let apiToContactHelloWorld = "http://www.volunteermatch.org/api/call?action=helloWorld"
        
        let apiToContactStatus = "http://www.volunteermatch.org/api/call?action=getServiceStatus"
        
        //let header = [X-WSSE: UsernameToken, Username: "carol"]
        
//        Account Name:   carol
//        Nonce:          7b6657cd2b624decf85d
//        Digest:         R/scZ2l6C289wqW7noYud266RUEIexpCX0pX4QEPCv4=
//        Creation Time:  2016-08-11T21:08:40+0000
        
        let headers = ["Authorization": "WSSE profile=\"UsernameToken\"" ,"X-WSSE": "UsernameToken Username=\"carol\", PasswordDigest=\"R/scZ2l6C289wqW7noYud266RUEIexpCX0pX4QEPCv4=\", Nonce=\"7b6657cd2b624decf85d\", Created=\"2016-08-11T21:08:40+0000\""]
        
        let params = ["location": "san francisco"]
        
        Alamofire.request(.GET, apiToContact, headers: headers, parameters: params).responseString { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    print(response)
                    print(response.result.value)
//                    let json = JSON(value)
//                    print(json)
                }
            case .Failure(let error):
                print("lol",error)
            }
        }
        
//        var url = NSURL(string: "http://www.volunteermatch.org/search/index.jsp#k=&v=false&s=&o=recency&l=New+York%2C+NY&r=20&sk=&specialGroupsData.groupSize=&na=&partner=&usafc=")
//        
//        if url != nil {
//            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
//                print(data)
//                
//                if error == nil {
//                    
//                    var urlContent = NSString(data: data!, encoding: NSASCIIStringEncoding) as NSString!
//                    
//                    print(urlContent)
//                }
//            })
//            task.resume()
//        }
    }

    
    //func searchWithTerm(term: String, parameters: Dictionary<String, String>? = nil, offset: Int = 0, limit: Int = 20, success: //(AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        //var params: NSMutableDictionary = [
            //"term": term,
            //"offset": offset,
            //"limit": limit
        //]
        //for (key, value) in parameters! {
            //params.setValue(value, forKey: key)
        //}
        //return self.GET("search", parameters: params, success: success, failure: failure)
    //}
    
}