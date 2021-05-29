//
//  SplashScreenInteractor.swift
//  Alarm
//
//  Created by KTB_User on 30/5/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol SplashScreenBusinessLogic {
  
}

protocol SplashScreenDataStore {
  
}

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
  var presenter: SplashScreenPresentationLogic?
  var worker: SplashScreenWorker?
  
  
}
