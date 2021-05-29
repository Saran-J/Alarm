//
//  SplashScreenRouter.swift
//  Alarm
//
//  Created by KTB_User on 30/5/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol SplashScreenRoutingLogic {
  
}

protocol SplashScreenDataPassing {
  var dataStore: SplashScreenDataStore? { get }
}

class SplashScreenRouter: NSObject, SplashScreenRoutingLogic, SplashScreenDataPassing {
  weak var viewController: SplashScreenViewController?
  var dataStore: SplashScreenDataStore?

}
