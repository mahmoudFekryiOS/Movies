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
    
    static func isConnectedToNetwork() -> Bool
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
    
    static func alamofireRequest(serviceURL:String , httpMethod:HTTPMethod , parameters:[String:Any]?,headers: HTTPHeaders?  , handler: @escaping (Dictionary<String,Any>? , Bool, Bool?) -> ()) {
        
        let url  = "\(Constants.baseUrl)\(serviceURL)"
        var header:HTTPHeaders = [:]
        header["Content-Type"] = "application/json"
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers:header).responseJSON { response in
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
    
    static func alamofireRequestJson(serviceURL:String , handler: @escaping (Any? , Bool) -> ()) {
        let url  = "\(Constants.baseUrl)\(serviceURL)"
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch (response.result) {
                case .success:
                    do{
                         //let jsonData = try JSONSerialization.data(withJSONObject: response.result.value as Any, options: [] )
                        //let json = try JSONSerialization.jsonObject(with: jsonData , options: .mutableContainers )
                        //print(jsonData)
                        handler(response.result.value, true)

                    }catch{
                        handler(nil, false)
                    }
                    break
                case .failure(let Error):
                    print(Error )
                    handler(nil, false)
                    break
                }
        }
    }
    
}
