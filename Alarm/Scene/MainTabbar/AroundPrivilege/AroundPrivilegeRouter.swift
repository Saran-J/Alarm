//
//  AroundPrivilegeRouter.swift
//  Alarm
//
//  Created by KTB_User on 30/5/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol AroundPrivilegeRoutingLogic {
}

protocol AroundPrivilegeDataPassing {
    var dataStore: AroundPrivilegeDataStore? { get }
}

class AroundPrivilegeRouter: NSObject, AroundPrivilegeRoutingLogic, AroundPrivilegeDataPassing {
    weak var viewController: AroundPrivilegeViewController?
    var dataStore: AroundPrivilegeDataStore?
}
