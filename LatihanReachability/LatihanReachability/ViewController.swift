//
//  ViewController.swift
//  LatihanReachability
//
//  Created by Gilang Ramadhan on 11/08/22.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func checkReachability(_ sender: Any) {
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.dicoding.com")
    var flags = SCNetworkReachabilityFlags()
    SCNetworkReachabilityGetFlags(reachability!, &flags)
    if !isNetworkReachable(with: flags) {
      print("Device doesn't have internet connection")
    } else {
      print("Host www.dicoding.com is reachable")
    }

    #if os(iOS)
    if flags.contains(.isWWAN) {
      print("Device is using mobile data")
    }
    #endif
  }
  
  func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
    let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
    return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
  }
}

