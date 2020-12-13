//
//  Swift+Alamofire.swift
//  news
//
//  Created by 张杰 on 2020/12/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias ReqRsponseSucess = (_ response: AnyObject) -> Void
typealias ReqRsponseFail = (_ error: AnyObject) -> Void
typealias NetworkStatus = (_ ZLNetworkStatus: Int32) -> Void

@objc enum ZLNetworkStatus: Int32 {
    case HttpUnknow         = -1 // 未知
    case HttpNoReachable      = 0 // 无网络
    case HttpWan            = 1 // 2g 3g 4g ...
    case HttpWifi           = 2 // wifi
}


struct HTTPAPI {
    static let hostname = "https://pixabay.com/api/?key=19323754-89ce0cee13361c697d0fe73e2"
}

enum methodType {
    case RequestMethodGet
    case RequestMethodPost
}

class HttpNetwork: NSObject {
    static let singleton = HttpNetwork()
    var zlNetworkStatus: ZLNetworkStatus = .HttpWifi
    private override init() {
        
    }
    
    public func getRequsetWith(url: String,
                               params: [String: Any]?,
                               success: @escaping ReqRsponseSucess,
                               error: @escaping ReqRsponseFail) {
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: Any] {
                    success(value as AnyObject)
                }
                break
            case .failure(let err):
                error(err as AnyObject)
                break
            }
        }
    }
    
    public func postRequstWith(url: String,
                               params: [String: Any]?,
                               success: @escaping ReqRsponseSucess,
                               error: @escaping ReqRsponseFail) {
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success :
                if let value = response.result.value as? [String: Any] {
                    success(value as AnyObject)
                }
                break
            case .failure(let err):
                error(err as AnyObject)
            }
        }
    }
    
    public func requestWith(url: String,
                            httpMethod: methodType,
                            params: [String: Any]?,
                            success: @escaping ReqRsponseSucess,
                            error: @escaping ReqRsponseFail) {
        switch httpMethod {
        case .RequestMethodGet:
            getRequsetWith(url: url, params: params, success: success, error: error)
            break
        default:
            postRequstWith(url: url, params: params, success: success, error: error)
            break
        }
    }
}

extension HttpNetwork {
    public func monitoringNetwork(networkStatus: @escaping NetworkStatus) {
        let reachbility = NetworkReachabilityManager()
        reachbility?.startListening()
        reachbility?.listener = { [weak self] status in
            guard let weakSelf = self else {
                return
            }
            if reachbility?.isReachable ?? false {
                switch status {
                case .notReachable:
                    weakSelf.zlNetworkStatus = .HttpNoReachable
                    break
                case .unknown:
                    weakSelf.zlNetworkStatus = .HttpUnknow
                    break
                case .reachable(.wwan):
                    weakSelf.zlNetworkStatus = .HttpWan
                    break
                case .reachable(.ethernetOrWiFi):
                    weakSelf.zlNetworkStatus = .HttpWifi
                    break
                }
            } else {
                weakSelf.zlNetworkStatus = .HttpNoReachable
            }
            networkStatus(weakSelf.zlNetworkStatus.rawValue)
        }
    }
}
