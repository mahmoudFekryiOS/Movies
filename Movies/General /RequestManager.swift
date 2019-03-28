//
//  RequestManager.swift
//  rnrn
//
//  Created by mahmoud fekry on 4/15/18.
//  Copyright © 2018 mahmoud fekry. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
class RequestManager {
    
    private static func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    private static func AlamofireRequest(serviceURL:String , httpMethod:HTTPMethod , parameters:[String:Any]?,headers: HTTPHeaders?  , handler: @escaping (Dictionary<String,Any>? , Bool, Bool?) -> ()) {
        
        let url  = "\(Constants.baseUrl)"//"\(serviceURL)"
        var header:HTTPHeaders = [:]
        header["Content-Type"] = "application/json"
        //header["Authorization"] = "Bearer " + Constants.accessToken
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseJSON { response in
            print(url )
            switch (response.result) {
            case .success:
                if let json = response.result.value as? Dictionary<String,Any>  {
                    handler(json, true, nil)
                    
                } else {
                    handler(nil, false,nil )
                }
                break
            case .failure(let Error):
                print(Error )
                handler(nil, false, true)
                break
            }
        }
    }
    
}
