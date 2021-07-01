//
//  ContactInteractor.swift
//  Alarm
//
//  Created by KTB_User on 1/7/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ContactBusinessLogic {
}

protocol ContactDataStore {
}

class ContactInteractor: ContactBusinessLogic, ContactDataStore {
    var presenter: ContactPresentationLogic?
    var worker: ContactWorker?
}
