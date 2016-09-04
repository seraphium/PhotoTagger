//
//  ImaggaRouter.swift
//  PhotoTagger
//
//  Created by Jackie Zhang on 2016/9/4.
//  Copyright © 2016年 Razeware LLC. All rights reserved.
//

import Foundation

import Alamofire


public enum ImaggaRouter {
  static let baseUrlPath = "http://api.imagga.com/v1"
  static let authenticationToken = "Basic YWNjXzhlYzE3MDkwNTE3NWU3Yjo0NzdkYzQ3MGZiYTZjYzVlYjhkNzMxM2U4MmJkOGNkYQ=="
  
  case Content
  case Tags(String)
  case Colors(String)
  
  
  public var URLRequest :NSMutableURLRequest {
    let result: (path: String, method: Alamofire.Method, parameters: [String: AnyObject]) = {
      switch self {
      case .Content:
        return ("/content", .POST, [String: AnyObject]())
        
      case .Tags(let contentId):
        let params = ["content" : contentId]
        return ("/tagging", .GET, params)
        
      case .Colors(let contentId):
        let params = ["content" : contentId, "extract_object_colors" : NSNumber(int:0)]
        return ("/colors", .GET, params)
        
      
      }
    }()
    
    let URL = NSURL(string: ImaggaRouter.baseUrlPath)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
    URLRequest.HTTPMethod = result.method.rawValue
    URLRequest.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
    URLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
    let encoding = Alamofire.ParameterEncoding.URL
    return encoding.encode(URLRequest, parameters: result.parameters).0
    
    
    
  }

}
